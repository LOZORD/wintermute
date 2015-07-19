import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/*******************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/

public class ProceduralLevels {

  private static class Room {
    int x;
    int y;
    boolean onLayoutPath = false;
    boolean onSolutionPath = false;
    boolean open = true;
    boolean start = false;
    boolean finish = false;
    boolean eastWall = true;
    boolean westWall = true;
    boolean northWall = true;
    boolean southWall = true;
  }

  static int roomHeight = 5;
  static int roomWidth = 10;

  public static void main(String[] args) {
    int xSize = 100;
    int ySize = 100;
    List<Room> solutionPath = new ArrayList();
    Room[][] rooms = new Room[ySize / roomHeight][xSize / roomWidth];
    for (int i = 0; i < rooms.length; i++) {
      for (int j = 0; j < rooms[0].length; j++) {
        rooms[i][j] = new Room();
      }
    }
    rooms[rooms.length - 1][rooms[0].length - 1].finish = true;
    rooms[0][0].start = true;

//    rooms[1][1].eastWall = true;
//    rooms[1][1].westWall = true;
//    rooms[5][5].eastWall = true;
//    rooms[5][6].eastWall = true;
//    rooms[6][6].eastWall = true;
//    rooms[5][6].southWall = true;
//    rooms[6][6].northWall = true;
    findPath(rooms, solutionPath, 0, 0, 2000, 1);
    printMap(rooms, roomHeight, roomWidth);
  }

  static boolean findPath(Room[][] rooms, List<Room> solutionPath, int x, int y, int minDistance, int dirIn) {
    // hit the edge of the board
    if (x < 0 || y < 0) return false;
//    printMap(rooms, roomHeight, roomWidth);
    if (x >= rooms[0].length || y >= rooms.length) return false;
    if (rooms[y][x].finish ) {
      if (minDistance <= 0) return true;
    }
    if (!rooms[y][x].open) return false;
    switch(dirIn) {
      case 1: rooms[y][x].southWall = false;
      case 2: rooms[y][x].westWall = false;
      case 3: rooms[y][x].northWall = false;
      case 4: rooms[y][x].eastWall = false;
    }
    rooms[y][x].onLayoutPath = true;
    switch(new Random().nextInt(4) + 1) {
      case 1: if (findPath(rooms, solutionPath, x,y - 1, minDistance - 1, 1) == true) {
        rooms[y][x].northWall = false;
        return true;
      }
      case 2: if (findPath(rooms, solutionPath, x + 1,y, minDistance - 1, 2) == true) {
        rooms[y][x].eastWall = false;
        return true;
      }
      case 3: if (findPath(rooms, solutionPath, x, y + 1, minDistance - 1, 3) == true) {
        rooms[y][x].southWall = false;
        return true;
      }
      case 4: if (findPath(rooms, solutionPath, x, y, minDistance - 1, 4) == true) {
        rooms[y][x].westWall = false;
        return true;
      }
    }
    rooms[y][x].onSolutionPath = false;
    return false;
  }

 /*
 function findPath(x, y, minDistance):
    if (x,y is goal and minDistance == 0) return true
    if (x,y not open) return false
    mark x,y as part of layout path
    switch(random number 1 out of 4):
        case 1: if (findPath(North of x,y, minDistance - 1) == true) return true
        case 2: if (findPath(East of x,y, minDistance - 1) == true) return true
        case 3: if (findPath(South of x,y, minDistance - 1) == true) return true
        case 4: if (findPath(West of x,y, minDistance - 1) == true) return true
    unmark x,y as part of solution path
    return false
   */

  private static void printMap(Room[][] rooms, int roomHeight, int roomWidth) {
    int y = 0;
    int x = 0;
    char obstacle = 'o';
    char[][] currentRow = new char[roomHeight][rooms.length * roomWidth];
    for (Room[] row : rooms) {
      x = 0;
      // clear out the buffer
      for (char[] subRow : currentRow) {
        for (int i = 0; i < subRow.length; i++) {
          subRow[i] = ' ';
        }
      }
      for (Room room : row) {
        if (room.eastWall) {
          for (int i = 0; i < roomHeight; i++) {
            currentRow[i][(x + 1) * roomWidth - 1] = obstacle;
          }
        }

        if (room.westWall) {
          for (int i = 0; i < roomHeight; i++) {
            currentRow[i][x * roomWidth] = obstacle;
          }
        }
        if (room.southWall) {
          for (int i = 0; i < roomWidth; i++) {
            currentRow[roomHeight - 1][(x) * roomWidth + i] = obstacle;
          }
        }

        if (room.northWall) {
          for (int i = 0; i < roomWidth; i++) {
            currentRow[0][x * roomWidth + i] = obstacle;
          }
        }
        if (room.eastWall && room.westWall && room.northWall && room.southWall) {
          for (int i = 0; i < roomWidth; i++) {
            for (int j = 0; j < roomHeight; j++) {
              currentRow[j][x * roomWidth + i] = obstacle;
            }
          }
        }
        x++;
      }
      for (char[] subRow : currentRow ) {
        System.out.println(new String(subRow));
      }
      y++;
    }
    System.out.println();
    System.out.println();
    System.out.println();
  }
}
