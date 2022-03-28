From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Mon, 28 Mar 2022 07:26:01 -0700
Subject: [PATCH v2 1/5] ARM: dts: aspeed-g6: remove FWQSPID group in
 pinctrl dtsi
In-Reply-To: <f55316d5-43cb-49cd-ba4b-6730c2a9b91c@www.fastmail.com>
References: <20220325154048.467245-1-quic_jaehyoo@quicinc.com>
 <20220325154048.467245-2-quic_jaehyoo@quicinc.com>
 <f55316d5-43cb-49cd-ba4b-6730c2a9b91c@www.fastmail.com>
Message-ID: <38f0359d-ccc9-d366-4323-de1224788dd3@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 3/27/2022 8:09 PM, Andrew Jeffery wrote:
> 
> 
> On Sat, 26 Mar 2022, at 02:10, Jae Hyun Yoo wrote:
>> FWSPIDQ2 and FWSPIDQ3 are not part of FWSPI18 interface so remove
>> FWQSPID group in pinctrl dtsi. These pins must be used with the
>> FWSPI pins that are dedicated for boot SPI interface which provides
>> same 3.3v logic level.
>>
>> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>> Fixes: 2f6edb6bcb2f ("ARM: dts: aspeed: Fix AST2600 quad spi group")
>> ---
>> Changes in v2:
>>   * Rebased it on the latest.
>>   * Updated 'Fixes' while rebasing it on the latest.
>>
>> Note:
>>   * Removing 'pinctrl_fwqspid_default' doesn't break any existing DT since
>>     it has not been used in any DTs.
> 
> Can you please send a patch to the bindings to drop the broken
> function/group given they never worked and no-one could be using them?

Sure, I'll send a bindings patch too in v3.

Thanks for your review!

-Jae

> Other than that,
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
