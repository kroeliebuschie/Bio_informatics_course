function(doc){
    //this function adds 5 to all the "number" fields
    if (doc.number) {
        emit (doc.compartment, doc.number+5);
    }
}
