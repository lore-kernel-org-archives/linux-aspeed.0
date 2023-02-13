From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 13 Feb 2023 09:44:28 +0100
Subject: [PATCH v2 3/3] dts: ast2600: Add reset config for I3C
In-Reply-To: <f426c3a22d64d076b007a0fc75dc95a389a9387f.1676267865.git.jk@codeconstruct.com.au>
References: <cover.1676267865.git.jk@codeconstruct.com.au>
 <f426c3a22d64d076b007a0fc75dc95a389a9387f.1676267865.git.jk@codeconstruct.com.au>
Message-ID: <4eed8885-a149-43b1-f6f6-f9b7fbb2f3b4@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/02/2023 07:02, Jeremy Kerr wrote:
> This change adds the reset line definitions for the AST2600 I3C block's
> reset inputs.

1. Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

2. This is not DTS. There is nothing from DTS here.
Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).


Best regards,
Krzysztof

