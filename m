From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 21 Sep 2018 08:09:11 +0200
Subject: [PATCH 1/4] mtd: spi-nor: aspeed: use command mode for reads
In-Reply-To: <CACPK8XePSehmuYTtJFYuNqUz_CQ4cQ6s4gdZ2rKNKUpO46yZKQ@mail.gmail.com>
References: <20180622121417.6762-1-clg@kaod.org>
 <20180622121417.6762-2-clg@kaod.org>
 <CACPK8Xf-XfxMVMewC5T6u1XzDX3idqk+FeGRLMC+xrKDqtWggg@mail.gmail.com>
 <CACPK8XePSehmuYTtJFYuNqUz_CQ4cQ6s4gdZ2rKNKUpO46yZKQ@mail.gmail.com>
Message-ID: <b4d99763-98d6-ef64-d1b2-bd86c6a10e12@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 09/21/2018 04:39 AM, Joel Stanley wrote:
> Hello Mark,
> 
> On Mon, 23 Jul 2018 at 21:42, Joel Stanley <joel@jms.id.au> wrote:
>>
>> On 22 June 2018 at 21:44, C?dric Le Goater <clg@kaod.org> wrote:
>>> When reading flash contents, try to use the "command mode" if the AHB
>>> window configured for the flash module is big enough. Else, just fall
>>> back to the "user mode" to perform the read.
>>>
>>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Are you waiting on anything from Cedric or myself for this series. If
> not, can we please get them queued for 4.20?

There is one typo on the definition of the timing register of the AST2400
SPI controller we should fix. It can come later. Apart from that, I don't 
see any changes I would like to do. May be a couple of variable renames to 
clarify the loop on the hclk cycles and delays to fit the U-Boot driver
which was proposed recently. Please tell me :)

Thanks,

C. 
