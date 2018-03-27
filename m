From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 27 Mar 2018 09:38:04 +0800
Subject: [PATCH 1/5] serial: Introduce UPSTAT_SYNC_FIFO for synchronised
 FIFOs
In-Reply-To: <20180323153350.GC25972@kroah.com>
References: <20180321025241.19785-1-jk@ozlabs.org>
 <20180321025241.19785-2-jk@ozlabs.org> <20180323153350.GC25972@kroah.com>
Message-ID: <004a2d60-5eae-040f-a944-308a8cf69af8@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Greg,

>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -678,7 +678,7 @@ static void uart_throttle(struct tty_struct *tty)
>>  	if (C_CRTSCTS(tty))
>>  		mask |= UPSTAT_AUTORTS;
>>  
>> -	if (port->status & mask) {
>> +	if (port->status & (mask | UPSTAT_SYNC_FIFO)) {
>>  		port->ops->throttle(port);
>>  		mask &= ~port->status;
>>  	}
> 
> Why not just set mask to UPSTAT_SYNC_FIFO at the top of this function?

That was a bit of a line call - my thinking was that SYNC_FIFO is a
little different from the calculated bit values in mask, hence keeping
it separate and adding it explicitly at the check

However, adding it to the declaration of mask is a little simpler, so
I'll redo that in v2.

Cheers,


Jeremy
