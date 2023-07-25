diff --git a/python/pyarrow/includes/libarrow_flight.pxd b/python/pyarrow/includes/libarrow_flight.pxd
index 34ba809438e2c..30adb20d0a702 100644
--- a/python/pyarrow/includes/libarrow_flight.pxd
+++ b/python/pyarrow/includes/libarrow_flight.pxd
@@ -172,7 +172,9 @@ cdef extern from "arrow/flight/api.h" namespace "arrow" nogil:
         CResult[unique_ptr[CFlightInfo]] Next()
 
     cdef cppclass CSimpleFlightListing" arrow::flight::SimpleFlightListing":
-        CSimpleFlightListing(vector[CFlightInfo]&& info)
+        # This doesn't work with Cython >= 3
+        # CSimpleFlightListing(vector[CFlightInfo]&& info)
+        CSimpleFlightListing(const vector[CFlightInfo]& info)
 
     cdef cppclass CFlightPayload" arrow::flight::FlightPayload":
         shared_ptr[CBuffer] descriptor
@@ -308,7 +310,10 @@ cdef extern from "arrow/flight/api.h" namespace "arrow" nogil:
     cdef cppclass CCallHeaders" arrow::flight::CallHeaders":
         cppclass const_iterator:
             pair[c_string, c_string] operator*()
+            # For Cython < 3
             const_iterator operator++()
+            # For Cython >= 3
+            const_iterator operator++(int)
             bint operator==(const_iterator)
             bint operator!=(const_iterator)
         const_iterator cbegin()
