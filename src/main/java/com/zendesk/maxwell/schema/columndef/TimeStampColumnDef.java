package com.zendesk.maxwell.schema.columndef;

import com.zendesk.maxwell.producer.MaxwellOutputConfig;

import java.sql.Timestamp;

public class TimeStampColumnDef extends ColumnDefWithLength {

	public TimeStampColumnDef(String name, String type, short pos, Long columnLength) {
		super(name, type, pos, columnLength);
	}

	@Override
	protected String formatValue(Object value, MaxwellOutputConfig config) throws ColumnDefCastException {
		Timestamp ts = TimeStampFormatter.extractTimestamp(value);
		String dateString = TimeStampFormatter.formatDateTime(value, ts);

		//System.out.println("3. "+value+" : "+ ts.toString() +" : " + dateString);

		if ( dateString == null )
			return null;
		else
			return appendFractionalSeconds(dateString, ts.getNanos(), columnLength);
	}

}
