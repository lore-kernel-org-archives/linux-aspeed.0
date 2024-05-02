From: Lee Jones <lee@kernel.org>
Date: Thu, 02 May 2024 18:23:29 +0100
Subject: (subset) [PATCH] dt-bindings: mfd: aspeed: Drop 'oneOf' for
 pinctrl node
In-Reply-To: <20240430172520.535179-1-robh@kernel.org>
References: <20240430172520.535179-1-robh@kernel.org>
Message-ID: <171467060972.1223907.593520549880230505.b4-ty@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 12:25:19 -0500, Rob Herring (Arm) wrote:
> The use of 'oneOf' to include 1 of 3 possible child node schemas results
> in error messages containing the actual error message(s) for the correct
> SoC buried in the tons of error messages from the 2 schemas that don't
> apply. It also causes the pinctrl schema to be applied twice as it will
> be applied when the compatible matches.
> 
> All that's really needed in the parent schema is to ensure one of the
> possible compatible strings is present in the pinctrl node so that its
> schema will be applied separately.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node
      commit: 8f553c27697bc5e11074e37dfc0def6e39e489b2

--
Lee Jones [???]

