-- Ejercicio 1

SELECT TOP (200) DisplayName,
      Location,
      Reputation
  FROM Users
  ORDER BY Reputation DESC;

-- Ejercicio 2

SELECT TOP (200) p.Title, u.DisplayName
FROM Posts p
INNER JOIN Users u ON p.OwnerUserId = u.Id
WHERE p.OwnerUserId IS NOT NULL AND p.Title IS NOT NULL

-- Ejercicio 3

SELECT TOP (200) u.DisplayName, AVG(CAST(p.Score AS FLOAT)) AS AverageScore
FROM Users u
INNER JOIN Posts p ON u.Id = p.OwnerUserId
WHERE p.OwnerUserId IS NOT NULL
GROUP BY u.Id, u.DisplayName
ORDER BY AverageScore DESC

-- Ejercicio 4

SELECT TOP (200) u.DisplayName
FROM Users u
WHERE u.Id IN (
    SELECT UserId
    FROM Comments
    GROUP BY UserId
    HAVING COUNT(*) > 100
)
ORDER BY u.DisplayName, u.Id

-- Ejercicio 5

UPDATE Users
SET Location = 'Desconocido'
WHERE Location IS NULL OR TRIM(Location) = ''

PRINT 'La actualización se realizó correctamente. Se actualizaron ' + 
      CAST(@@ROWCOUNT AS VARCHAR(10)) + ' filas.'

-- Para ver:
SELECT TOP 200 DisplayName, Location
FROM Users
WHERE Location = 'Desconocido'
ORDER BY DisplayName

-- Ejercicio 6

DELETE Comments
FROM Comments
JOIN Users On Comments.UserId = Users.Id
WHERE Users.Reputation < 100;

DECLARE @DeletedCount INT;
SET @DeletedCount = @@ROWCOUNT;
PRINT CAST(@DeletedCount AS VARCHAR) + ' comentarios fueron eliminados.';

-- Ejercicio 7

SELECT TOP 200
    u.DisplayName,
    (SELECT COUNT(*) FROM Posts WHERE OwnerUserId = u.Id) AS TotalPosts,
    (SELECT COUNT(*) FROM Comments WHERE UserId = u.Id) AS TotalComments,
    (SELECT COUNT(*) FROM Badges WHERE UserId = u.Id) AS TotalBadges
FROM 
    Users u
ORDER BY 
    TotalPosts DESC, u.DisplayName

-- Ejercicio 8

SELECT TOP 10
    Title,
    Score
FROM 
    Posts
WHERE 
    Title IS NOT NULL
ORDER BY 
    Score DESC

-- Ejercicio 9

SELECT TOP 5 Text, CreationDate
  FROM Comments
  ORDER BY 
    CreationDate DESC

