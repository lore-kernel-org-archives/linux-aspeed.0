From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 2 Aug 2024 11:18:47 +0200
Subject: [PATCH v2 0/9] Introduce ASPEED AST27XX BMC SoC
In-Reply-To: <20240802090544.2741206-2-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
 <20240802090544.2741206-2-kevin_chen@aspeedtech.com>
Message-ID: <ba9cc5ea-4138-4e9c-b848-c7a3a070bd73@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/08/2024 11:05, Kevin Chen wrote:
> This patchset adds initial support for the ASPEED.
> AST27XX Board Management controller (BMC) SoC family.
> 
> AST2700 is ASPEED's 8th-generation server management processor.
> Featuring a quad-core ARM Cortex A35 64-bit processor and two
> independent ARM Cortex M4 processors
> 
> This patchset adds minimal architecture and drivers such as:
> Clocksource, Clock and Reset
> 
> This patchset was tested on the ASPEED AST2700 evaluation board.

Where is the changelog? You ignored several comments, did not bother to
respond them, did not implement them.

No changelog means you sent exactly the same? This is not how it works.
Please read submitting patches, respond to all comments or implement
them, provide *DETAILED* changelog in the cover letter or individual
patches (---).

Best regards,
Krzysztof

