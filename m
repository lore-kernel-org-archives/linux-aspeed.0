From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 08 Mar 2022 11:32:43 +1030
Subject: [PATCH] pinctrl: aspeed: Add FWQSPI pinmux
In-Reply-To: <73a487ed-312b-72b3-4e64-dc580ba80704@quicinc.com>
References: <20220308003136.3930466-1-quic_jaehyoo@quicinc.com>
 <d2f125d8-07d1-4bff-8718-7dfba4d8fdb3@www.fastmail.com>
 <73a487ed-312b-72b3-4e64-dc580ba80704@quicinc.com>
Message-ID: <e541828f-f0bc-419a-a5fc-d8aefe97832d@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 8 Mar 2022, at 11:16, Jae Hyun Yoo wrote:
> Hi Andrew,
>
> On 3/7/2022 4:41 PM, Andrew Jeffery wrote:
>> 
>> 
>> On Tue, 8 Mar 2022, at 11:01, Jae Hyun Yoo wrote:
>>> From: Johnny Huang <johnny_huang@aspeedtech.com>
>>>
>>> AST2600 FW SPI quad mode only need to set AE12 and AF12, no need
>>> to set Y1~Y4. FW SPI cs, clk, mosi and miso pins are dedicated.
>> 
>> They're not dedicated according to the datasheet?
>> 
>> Can you please look at this patch?
>> 
>> https://lore.kernel.org/all/20220304011010.974863-1-joel at jms.id.au/
>
> Sorry. Please ignore this patch.
> I mistakenly sent this patch while making a patch series.
>
> Please check this patch series instead.
> https://lore.kernel.org/linux-arm-kernel/20220308003745.3930607-1-quic_jaehyoo at quicinc.com/T/#t

No worries, I'll take a look though it might be a couple of days due to chasing some other issues.

Andrew
