From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 14 Aug 2024 17:14:20 +0200
Subject: [PATCH v2 0/2] Add support for AST2700 INTC
In-Reply-To: <20240814114106.2809876-2-kevin_chen@aspeedtech.com>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
 <20240814114106.2809876-2-kevin_chen@aspeedtech.com>
Message-ID: <1bf9edfe-5b32-4382-83d4-5be91e6c036e@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/08/2024 13:41, Kevin Chen wrote:
> Support for the Aspeed Interrupt Controller found on Aspeed 7th Geration Silicon
> SoCs.
> 
> ASPEED interrupt controller(INTC) maps the internal interrupt sources of
> the AST27XX devices to an parent interrupt controller.
> 
> Changes since v2:
> Combine the aspeed_intc_ic_of_init and aspeed_intc_ic_of_init_v2.
> Switch raw_spin_lock_irqsave to scoped_guard and guard.
> Fix the error of make dt_binding_check.
> Refine the aspeed,ast2700-intc.yaml.

It seems that entire Aspeed has troubles working with people in the
community. You do not address feedback, you ignore it and asks us to
re-review the same crap.

Before we proceed further:
1. Answer, inline, without confidentiality notice (after asking you this
5 times, I think you should fix it finally) that you:
 - agree (ack/ok/agree)
 - disagree with explanation why

2. Then double check that your new version implements everything above.

3. Then send new version (max once per 24h) with changelog and
versioning (just use `b4`).

If you keep ignoring step 1 and 2, you will annoy reviewers up to the
point of automatic NAK or being ignored.

Best regards,
Krzysztof

