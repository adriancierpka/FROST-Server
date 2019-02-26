package de.fraunhofer.iosb.ilt.sta.persistence.pgjooq.tables;

import de.fraunhofer.iosb.ilt.sta.persistence.pgjooq.bindings.JsonBinding;
import de.fraunhofer.iosb.ilt.sta.persistence.pgjooq.bindings.JsonValue;
import org.jooq.Field;
import org.jooq.Name;
import org.jooq.Record;
import org.jooq.TableField;
import org.jooq.impl.DSL;
import org.jooq.impl.DefaultDataType;
import org.jooq.impl.SQLDataType;
import org.jooq.impl.TableImpl;

public abstract class AbstractTableThings<J> extends TableImpl<Record> implements StaTable<J> {

    private static final long serialVersionUID = -729589982;

    @Override
    public abstract TableField<Record, J> getId();

    /**
     * The column <code>public.THINGS.DESCRIPTION</code>.
     */
    public final TableField<Record, String> description = createField("DESCRIPTION", SQLDataType.CLOB, this, "");

    /**
     * The column <code>public.THINGS.PROPERTIES</code>.
     */
    public final TableField<Record, JsonValue> properties = createField("PROPERTIES", DefaultDataType.getDefaultDataType("\"pg_catalog\".\"jsonb\""), this, "", new JsonBinding());

    /**
     * The column <code>public.THINGS.NAME</code>.
     */
    public final TableField<Record, String> name = createField("NAME", SQLDataType.CLOB.defaultValue(DSL.field("'no name'::text", SQLDataType.CLOB)), this, "");

    /**
     * Create a <code>public.THINGS</code> table reference
     */
    protected AbstractTableThings() {
        this(DSL.name("THINGS"), null);
    }

    protected AbstractTableThings(Name alias, AbstractTableThings<J> aliased) {
        this(alias, aliased, null);
    }

    protected AbstractTableThings(Name alias, AbstractTableThings<J> aliased, Field<?>[] parameters) {
        super(alias, null, aliased, parameters, DSL.comment(""));
    }

    @Override
    public abstract AbstractTableThings<J> as(Name as);

    @Override
    public abstract AbstractTableThings<J> as(String alias);

}
