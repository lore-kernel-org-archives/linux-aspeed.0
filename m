From: 梁礼学 <lianglixuehao@126.com>
Date: Thu, 10 Aug 2023 09:30:52 +0800 (CST)
Subject: [PATCH] i2c: aspeed: Avoid accessing freed buffers during
 i2c transfers.
In-Reply-To: <388f1d61-c419-a133-6266-daff1fa4cd60@linux.ibm.com>
References: <20230728122416.17782-1-lianglixuehao@126.com>
 <CACPK8Xf6YssamEmHB5XDf8JYk+_=hnG8Yzqn4kCikseqg6rqOA@mail.gmail.com>
 <CAARXrtmZbu3aabYJkEc25rHymRHDX4=zNdecHAs3LnQ259RkPg@mail.gmail.com>
 <388f1d61-c419-a133-6266-daff1fa4cd60@linux.ibm.com>
Message-ID: <1eb66406.e3a.189dd11655f.Coremail.lianglixuehao@126.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,
I can't see from https://lore.kernel.org/openbmc/374237cb-1cda-df12-eb9f-7422cab51fc4 at linux.alibaba.com/ why the patch was rejected.
can you tell me why? After all, this problem will always happen.


Thanks.














At 2023-08-02 21:41:16, "Eddie James" <eajames@linux.ibm.com> wrote:
>
>On 7/31/23 01:10, Lei YU wrote:
>> There is a same fix in 
>> https:?//lore.?kernel.?org/openbmc/374237cb-1cda-df12-eb9f-7422cab51fc4@?linux.?alibaba.?com/ 
>> On Mon, Jul 31, 2023 at 12:?21 PM Joel Stanley <joel@?jms.?id.?au> 
>> wrote: On Fri, 28 Jul 2023 at 12:?40, Lixue Liang 
>> <lianglixuehao@?126.?com>
>> ZjQcmQRYFpfptBannerStart
>> This Message Is From an Untrusted Sender
>> You have not previously corresponded with this sender.
>> Report Suspicious
>> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/PjiDSg!12-vrJBTB7HSMYjxkCEvpHwVyelw0CenAD3RKRjmVVfRig6DzCgRBaxHaeYsJsATzFgNYSRGXy6rQNXpmK9YdWQxScm-2h9p_bilDuLeU1r8NS5OEkCngl01P94y$> 
>>
>> ZjQcmQRYFpfptBannerEnd
>> There is a same fix in 
>> https://lore.kernel.org/openbmc/374237cb-1cda-df12-eb9f-7422cab51fc4 at linux.alibaba.com/
>>
>> On Mon, Jul 31, 2023 at 12:21?PM Joel Stanley <joel@jms.id.au> wrote:
>>
>>     On Fri, 28 Jul 2023 at 12:40, Lixue Liang <lianglixuehao@126.com>
>>     wrote:
>>     >
>>     > From: Lixue Liang <lianglixue@greatwall.com.cn>
>>     >
>>     > After waiting for the transmission timeout, the I2C controller will
>>     > continue to transmit data when the bus is idle. Clearing
>>     bus->msg will
>>     > avoid kernel panic when accessing the freed msg->buf in
>>     > aspeed_i2c_master_irq.
>>     >
>>     > Signed-off-by: Lixue Liang <lianglixue@greatwall.com.cn>
>>     > ---
>>     >  drivers/i2c/busses/i2c-aspeed.c | 2 ++
>>     >  1 file changed, 2 insertions(+)
>>     >
>>     > diff --git a/drivers/i2c/busses/i2c-aspeed.c
>>     b/drivers/i2c/busses/i2c-aspeed.c
>>     > index 2e5acfeb76c8..c83057497e26 100644
>>     > --- a/drivers/i2c/busses/i2c-aspeed.c
>>     > +++ b/drivers/i2c/busses/i2c-aspeed.c
>>     > @@ -713,6 +713,8 @@ static int aspeed_i2c_master_xfer(struct
>>     i2c_adapter *adap,
>>     >                 spin_lock_irqsave(&bus->lock, flags);
>>     >                 if (bus->master_state == ASPEED_I2C_MASTER_PENDING)
>>     >                         bus->master_state =
>>     ASPEED_I2C_MASTER_INACTIVE;
>>     > +
>>     > +               bus->msgs = NULL;
>>
>>     Eddie, is this the same issue you were debugging?
>>
>
>Yes, it is, and the same fix I settled on.
>
>
>>
>>     >  spin_unlock_irqrestore(&bus->lock, flags);
>>     >
>>     >                 return -ETIMEDOUT;
>>     > --
>>     > 2.27.0
>>     >
>>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230810/42868972/attachment-0001.htm>
