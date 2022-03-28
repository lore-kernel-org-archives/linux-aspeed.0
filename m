From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Mon, 28 Mar 2022 07:43:03 -0700
Subject: [PATCH v2 5/5] ARM: dts: aspeed-g6: fix SPI1/SPI2 quad pin group
In-Reply-To: <8a381a39-a6f9-43d6-bfc4-6cf2ae4ead1f@www.fastmail.com>
References: <20220325154048.467245-1-quic_jaehyoo@quicinc.com>
 <20220325154048.467245-6-quic_jaehyoo@quicinc.com>
 <8a381a39-a6f9-43d6-bfc4-6cf2ae4ead1f@www.fastmail.com>
Message-ID: <42d184cf-92a7-006d-7b34-65a93792f5af@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 3/27/2022 8:16 PM, Andrew Jeffery wrote:
> 
> 
> On Sat, 26 Mar 2022, at 02:10, Jae Hyun Yoo wrote:
>> Fix incorrect function mappings in pinctrl_qspi1_default and
>> pinctrl_qspi2_default since there function should be SPI1 and
>> SPI2 respectively.
>>
>> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>> Fixes: f510f04c8c83 ("ARM: dts: aspeed: Add AST2600 pinmux nodes")
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Thanks for your review!

-Jae
