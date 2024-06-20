USE `movies`;
SET lc_time_names = 'es_AR';

#1) ¿Cuántas películas tienen como promedio de votos 6? Considerar el
#promedio redondeado y tener en cuenta solamente las películas con más
#de 4000 votos (cantidad_votos)

SELECT 
	`pelicula_id`,
    `titulo`,
    `cantidad_votos`
FROM
	`pelicula`WHERE 
	`cantidad_votos` > 4000
    AND ROUND(`promedio_votos`) = 6;

#2) ¿Cuál fue la recaudación promedio de las películas clasificadas en la
#categoría Crime en el año 2002? Mostrar el resultado por mes (con el
#nombre del mes, no el numero) y ordenados cronológicamente)

# -> sucess
## 12 rows / 0.016sec

SELECT 
	MONTHNAME(`fecha_estreno`) AS `mes`,
    AVG(`ingresos`) AS `promedio recaudado`
FROM
	`pelicula` AS `P`
INNER JOIN 
	`pelicula_categorias` AS `PCA`
    ON `P`.`pelicula_id` = `PCA`.`pelicula_id`
INNER JOIN
	`categoria` AS `CA`
	ON `CA`.`categoria_id` = `PCA`.`categoria_id`
WHERE
	`CA`.`categoria_nombre` = 'Crime'
    AND YEAR(`P`.`fecha_estreno`) = 2002
GROUP BY
	`mes`, MONTH(`fecha_estreno`)
ORDER BY
	MONTH(`fecha_estreno`);

#3) En qué películas trabajo como “Editor” una persona cuyo primer nombre
#es “Chris”. Mostrar como resultado, el título, el nombre completo y el
#trabajo.
# -> sucess

SELECT
	`pelicula`.`titulo`,
	`persona`.`persona_nombre`,
    `PE`.`trabajo`
FROM
	`pelicula_equipo` AS `PE`
INNER JOIN
	`persona`
	ON `PE`.`persona_id` = `persona`.`persona_id`
INNER JOIN
	`pelicula`
	ON `pelicula`.`pelicula_id` = `PE`.`pelicula_id`
WHERE
	`PE`.`trabajo` = 'Editor'
    AND `persona`.`persona_nombre` LIKE 'Chris %';


#4) ¿En qué película estrenada en el año 2002 se hablan más idiomas?
#Mostrar el id, título y duración

# -> sucess

SELECT
	`pelicula`.`pelicula_id`,
    `pelicula`.`titulo`,
    `pelicula`.`duracion`
FROM (
    SELECT
		COUNT(*) AS `idiomas`,
        `pelicula_id`
	FROM
		`pelicula_idiomas`
	GROUP BY
		`pelicula_id`
    ) AS `I`
INNER JOIN
	`pelicula`
    ON `pelicula`.`pelicula_id` = `I`.`pelicula_id`
WHERE
	YEAR(`pelicula`.`fecha_estreno`) = 2002
    AND `I`.`idiomas` = (
		SELECT
			MAX(`idiomas`)
		FROM (
			SELECT 
				`pelicula`.`pelicula_id`,
				COUNT(*) AS `idiomas`
			FROM
				`pelicula_idiomas`
			INNER JOIN
				`pelicula`
				ON `pelicula_idiomas`.`pelicula_id` = `pelicula`.`pelicula_id`
			WHERE
				YEAR(`pelicula`.`fecha_estreno`) = 2002
			GROUP BY `pelicula`.`pelicula_id`)
            AS `MAX`
		);

#5) ¿En qué película/s actuaron juntos Jennifer Lawrence y Stanley Tucci?
#Mostrar en cada caso el título de la película, y el nombre de cada actor o
#actriz junto con el nombre del personaje que interpretaron.

# -> sucess
## 4 rows returned / 0.68 sec

SELECT 
	`pelicula`.`titulo`,
	`P1`.`persona_nombre` AS `actor`, 
	`PE1`.`personaje_nombre`AS `actor_personaje`,
	`P2`.`persona_nombre` AS `actriz`,
	`PE2`.`personaje_nombre` AS `actriz_personaje`
FROM
	`pelicula`
INNER JOIN 
	`pelicula_elenco` AS `PE1`
    ON `pelicula`.`pelicula_id` = `PE1`.`pelicula_id`
INNER JOIN 
	`persona` AS `P1`
    ON `P1`.`persona_id` = `PE1`.`persona_id`
INNER JOIN 
	`pelicula_elenco` AS `PE2`
    ON `pelicula`.`pelicula_id` = `PE2`.`pelicula_id`
INNER JOIN 
	`persona` AS `P2`
    ON `PE2`.`persona_id` = `P2`.`persona_id`
WHERE 
	`P1`.`persona_nombre` = 'Stanley Tucci'
    AND `P2`.`persona_nombre` = 'Jennifer Lawrence';

#6) ¿En qué país o países se filmaron las películas que tienen la palabra
#clave “peseta”? Mostrar el código ISO y el nombre del país.

SELECT
	`pais`.`pais_codigo_iso`,
    `pais`.`pais_nombre`
FROM
	`pelicula_pais` AS `PP`
INNER JOIN
	`pelicula_palabra_claves` AS `PPC`
	ON `PPC`.`pelicula_id` = `PP`.`pelicula_id`
INNER JOIN
	`palabra_clave` AS `PC`
    ON `PPC`.`palabra_clave_id` = `PC`.`palabra_clave_id`
INNER JOIN
	`pais`
    ON `pais`.`pais_id` = `PP`.`pais_id`
WHERE
	`PC`.`palabra_clave_nombre` = 'peseta';


#7) ¿Cuántas películas de la categoría Crime no tienen en su elenco
#personajes de genero Female? Listar las primeras 10 en orden de estreno
#(las más nuevas primero), mostrando el id de la película, el título y la fecha
#de estreno.

SELECT DISTINCT 
	`P`.`pelicula_id`,
   	`P`.`titulo`,
    	`P`.`fecha_estreno`
FROM
	`pelicula` AS `P`
LEFT JOIN 
	`pelicula_elenco`
	ON `P`.`pelicula_id` = `pelicula_elenco`.`pelicula_id`
LEFT JOIN
	`genero` AS `G` 
	ON `G`.`genero_id` = `pelicula_elenco`.`genero_id`
INNER JOIN 
	`pelicula_categorias`
	ON `P`.`pelicula_id` = `pelicula_categorias`.`pelicula_id`
INNER JOIN 
	`categoria` AS `C`
	ON `C`.`categoria_id` = `pelicula_categorias`.`categoria_id`
WHERE 
	`P`.`pelicula_id`
NOT IN (
	SELECT DISTINCT
		`pelicula_elenco`.`pelicula_id`
	FROM 
		`pelicula_elenco`
	INNER JOIN 
		`genero` AS `G` 
		ON `G`.`genero_id` = `pelicula_elenco`.`genero_id`
	WHERE 
		`G`.`genero` = 'Female')
AND `C`.`categoria_nombre` = 'Crime'
ORDER BY
	`P`.`fecha_estreno` DESC
LIMIT 10;


#### preguntas del recuperatorio

#1) Entre qué años dirigió películas Steven Spielberg, cuántas películas dirigió, y cuanto recaudó. Indicar además en
#cuántos casos lo recaudado superó el presupuesto de la película.
#Resultado esperado (*):

#cuántas películas dirigió, y cuanto recaudó. Indicar además en
#cuántos casos lo recaudado superó el presupuesto de la película
SELECT
	YEAR(MIN(`pelicula`.`fecha_estreno`)) AS `Inicio`,
    YEAR(MAX(`pelicula`.`fecha_estreno`)) AS `Ultima`,
    COUNT(`pelicula`.`pelicula_id`) AS `Cantidad`,
    (SELECT
		COUNT(*)
	FROM
		`pelicula_equipo`
	INNER JOIN
		`persona`
        ON `persona`.`persona_id` = `pelicula_equipo`.`persona_id`
	INNER JOIN `pelicula`
		ON `pelicula`.`pelicula_id` = `pelicula_equipo`.`pelicula_id`
	WHERE
		`persona_nombre` = 'Steven Spielberg'
		 AND `trabajo` = 'Director'
         AND `pelicula`.`ingresos` > `pelicula`.`presupuesto`
    ) AS `SuperoPresupuesto`,
    FORMAT(SUM(`pelicula`.`ingresos`), 4) AS `Ingresos`
FROM
	`pelicula`
INNER JOIN
	`pelicula_equipo`
    ON `pelicula_equipo`.`pelicula_id` = `pelicula`.`pelicula_id`
INNER JOIN
	`persona`
    ON `persona`.`persona_id` = `pelicula_equipo`.`persona_id`
WHERE
	`persona_nombre` = 'Steven Spielberg'
	 AND `trabajo` = 'Director'
GROUP BY `SuperoPresupuesto`;

#2) Listar las películas de la categoría Science Fiction, con ingresos mayores a 100.000.000, en las que no haya
#participado Steven Spielberg, ni como equipo, ni como elenco. Mostrar ID, titulo, presupuesto, ingresos y ROI
#(Return On Investment).


SELECT
	`pelicula`.`pelicula_id`,
	`pelicula`.`titulo`,
    `pelicula`.`presupuesto`,
    `pelicula`.`ingresos` /*falta agregar ROI*/
FROM 
	`pelicula`
INNER JOIN
	`pelicula_categorias`
	ON `pelicula_categorias`.`pelicula_id` = `pelicula`.`pelicula_id`
INNER JOIN
	`categoria`
    ON `pelicula_categorias`.`categoria_id` = `categoria`.`categoria_id`
WHERE
	(`categoria`.`categoria_nombre` = 'Science Fiction'
	AND `pelicula`.`ingresos` > 100000000)
    AND `pelicula`.`pelicula_id` NOT IN (
		SELECT DISTINCT
			`pelicula_elenco`.`pelicula_id`
		FROM 
			`persona`
		INNER JOIN
			`pelicula_equipo`
			ON `persona`.`persona_id` = `pelicula_equipo`.`persona_id`
		INNER JOIN
			`pelicula_elenco`
			ON `pelicula_elenco`.`persona_id` = `persona`.`persona_id`
		WHERE `persona`.`persona_nombre` = 'Steven Spielberg'
    );