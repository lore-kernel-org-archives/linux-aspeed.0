From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Tue, 30 Nov 2021 09:08:05 +0700
Subject: [PATCH v5 1/3] i2c: aspeed: Add slave_enable() to toggle slave
 mode
In-Reply-To: <YaUoeFZn6zLNoGed@kunai>
References: <20210714033833.11640-1-quan@os.amperecomputing.com>
 <20210714033833.11640-2-quan@os.amperecomputing.com>
 <YRTQP9sX0hkTJMTx@shikoro> <YaUoeFZn6zLNoGed@kunai>
Message-ID: <b8ee3be7-c0f6-d1fd-1ba1-13066b329ee3@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 30/11/2021 02:22, Wolfram Sang wrote:
> Hi,
> 
> I still wonder if we can't get the SSIF BMC driver upstream...
> 

Thanks Wolfram to help bring this up,

This driver was tested with Aspeed ast2500 and we have tried many way to 
avoid using slave_enable() to toggle slave mode but there is no progress.
Our expectation is still to have this driver upstream'ed and I'm 
thinking about testing this driver on other HW and re-post the driver.

>> @all: Plus, I neither like the API (because it doesn't look generic to
>> me but mostly handling one issue needed here) nor do I fully understand
>> the use case. Normally, when a read is requested and the backend needs
>> time to deliver the data, the hardware should stretch the SCL clock
>> until some data register is finally written to. If it doesn't do it for
>> whatever reason, this is a quirky hardware in my book and needs handling
>> in the driver only. So, what is special with this HW? Can't we solve it
>> differently?
> 
> ... for that, it would be great if somebody could answer my questions
> here :)
> 

I have to admit that you are all right with the above comments. The fact 
is we still not be able to find any way to solve this differently. We 
don't own this HW and dont know what happen on this particular issue. 
The SCL clock stretching on this HW does not work as expected and the 
slave_enable() is the only solution for now. I hope if someone could 
help with the issue as well.

Best regards,
- Quan



