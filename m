From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Feb 2023 16:55:38 +0800
Subject: [RFC PATCH] dt-bindings: Add AST2600 i3c controller binding
In-Reply-To: <7c6741e1-ae41-ba20-b859-736214c680e8@linaro.org>
References: <5c047dd91390b9ee4cd8bca3ff107db37a7be4ac.1676273912.git.jk@codeconstruct.com.au>
	 <7c6741e1-ae41-ba20-b859-736214c680e8@linaro.org>
Message-ID: <91e9e815bed8c2eff19dbe6b3ed36d10c6edcbfd.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

> 1. Do not use "This commit/patch".
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

OK.

> 2. Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the
> directory your patch is touching).

So "dt-bindings: i3c:" instead of just "d-bindings:" here.

> 3. Subject: drop second/last, redundant "binding". The "dt-bindings"
> prefix is already stating that these are bindings.

OK.

> 4. Where is the driver? Where is the DTS? Why do we want unused
> binding in the kernel?

The driver is coming next, but I wanted to sort out the structure of the
binding before committing to how the driver consumes the DT data - hence
the RFC.

Cheers,


Jeremy
