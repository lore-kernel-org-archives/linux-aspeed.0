From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 27 Mar 2018 09:44:02 +0800
Subject: [PATCH 2/5] serial: expose buf_overrun count through proc
 interface
In-Reply-To: <20180323152931.GB25972@kroah.com>
References: <20180321025241.19785-1-jk@ozlabs.org>
 <20180321025241.19785-3-jk@ozlabs.org> <20180323152931.GB25972@kroah.com>
Message-ID: <c7eea27e-bf63-c083-1cfd-0c2e1b095f60@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Greg,

>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 8f3dfc8b5307..fc677534b510 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1780,6 +1780,8 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
>>  			seq_printf(m, " brk:%d", uport->icount.brk);
>>  		if (uport->icount.overrun)
>>  			seq_printf(m, " oe:%d", uport->icount.overrun);
>> +		if (uport->icount.buf_overrun)
>> +			seq_printf(m, " bo:%d", uport->icount.buf_overrun);
> 
> Hopefully this doesn't break any tools that might want to parse this
> file :)

Given that those existing fe/pe/brk/oe fields only appear when they're
non-zero, existing parsing code needs to be tolerant of different sets
of fields being present/absent. Hopefully that means that a new field
shouldn't be too much of a surprise?

Otherwise, I'm happy to report the buf_overrun count elsewhere, if
there's a more suitable place.

Cheers,


Jeremy
