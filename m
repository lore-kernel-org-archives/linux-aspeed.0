From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 14 Aug 2024 17:11:00 +0200
Subject: [PATCH v2 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <87plqbnnyx.ffs@tglx>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
 <20240814114106.2809876-4-kevin_chen@aspeedtech.com> <87plqbnnyx.ffs@tglx>
Message-ID: <71497232-71f0-4b51-95d8-e054ec87c479@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/08/2024 17:06, Thomas Gleixner wrote:
> On Wed, Aug 14 2024 at 19:41, Kevin Chen wrote:
>> Support for the Aspeed Interrupt Controller found on Aspeed Silicon SoCs,
>> such as the AST2700, which is arm64 architecture.
>>
>> To support ASPEED interrupt controller(INTC) maps the internal interrupt
>> sources of the AST27XX device to an parent interrupt controller.
> 
> This still lacks a Signed-off-by: tag and my comment about the error
> path in the init function is still valid.
> 
> Do you think that addressing review feedback is optional?
> 
> Feel free to ignore it, but don't be surprised if I ignore further
> patches from you.
> 
> Take your time and go through stuff properly and do not rush out half
> baked patches in a frenzy.
>

That's like fourth or fifth patchset for AST27xx within last week and
all previous ones ignored given feedback. It's like sending almost the
same stuff hoping maintainers will get bored and finally accept it.

Tricky to say, maybe this works well in corporations?

Best regards,
Krzysztof

