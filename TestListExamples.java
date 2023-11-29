import static org.junit.Assert.*;

import org.junit.*;
import java.util.ArrayList;
import java.util.List;

public class TestListExamples {
    public void makeList(List<String> list, String... elements) {
        for (String s : elements) {
            list.add(s);
        }
    }

    @Test
    public void testFilter() {
        List<String> input1 = new ArrayList<>();
        makeList(input1, "a", "b", "c", "d");
        assertEquals(new ArrayList<String>(), ListExamples.filter(input1, s -> false));
        List<String> input2 = new ArrayList<>();
        makeList(input2, "a", "b", "c", "d", "e2");
        assertEquals(input1, ListExamples.filter(input2, s -> s.length() == 1));
    }

    @Test
    public void testMerge() {
        List<String> input1 = new ArrayList<>();
        makeList(input1, "a", "b", "c", "d");
        List<String> input2 = new ArrayList<>();
        makeList(input2, "a", "b", "c", "d");
        List<String> expected = new ArrayList<>();
        makeList(expected, "a", "a", "b", "b", "c", "c", "d", "d");
        assertEquals(expected, ListExamples.merge(input1, input2));
    }

    @Test
    public void testMerge1() {
        List<String> input3 = new ArrayList<>();
        makeList(input3, "e", "f", "g", "h");
        List<String> input4 = new ArrayList<>();
        makeList(input4, "a", "b", "c", "d");

        List<String> expected2 = new ArrayList<>();
        makeList(expected2, "a", "b", "c", "d", "e", "f", "g", "h");
        assertEquals(expected2, ListExamples.merge(input3, input4));
    }

    @Test
    public void testMerge2() {
        List<String> input5 = new ArrayList<>();
        makeList(input5, "a");
        assertEquals(input5, ListExamples.merge(input5, new ArrayList<>()));
    }



    @Test
    public void testMerge3() {
      List<String> input6 = new ArrayList<>();
        makeList(input6, "a", "e", "f", "g");
        List<String> input7 = new ArrayList<>();
        makeList(input7, "b", "c", "d");
        List<String> expected3 = new ArrayList<>();
        makeList(expected3, "a", "b", "c", "d", "e", "f", "g");
        assertEquals(new ArrayList<>(), ListExamples.merge(new ArrayList<>(), new ArrayList<>()));

    }





}
