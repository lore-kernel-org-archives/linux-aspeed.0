From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 15 Apr 2024 09:39:22 +0930
Subject: [PATCH v3 2/4] dt-bindings: rtc: convert trivial devices into
 dtschema
In-Reply-To: <20240413-rtc_dtschema-v3-2-eff368bcc471@gmail.com>
References: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
	 <20240413-rtc_dtschema-v3-2-eff368bcc471@gmail.com>
Message-ID: <82fcd7a4532df119f82ea55208f592460ba5358e.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2024-04-13 at 22:22 +0200, Javier Carrasco wrote:
> These RTCs meet the requirements for a direct conversion into
> trivial-rtc:
> 
> - google,goldfish-rtc
> - maxim,ds1742
> - lpc32xx-rtc
> - orion-rtc
> - rtc-aspeed
> - spear-rtc
> - via,vt8500-rtc
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

We have trailers above but then there's more commit message content
below. Looks like what's below should be trimmed out (bad squash)?
Maybe the trimming could be done as its applied?

> 
> dt-bindings: rtc: lpc32xx-rtc: convert to dtschema
> 
> Convert existing binding to dtschema to support validation.
> 
> Add the undocumented 'clocks' property.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Andrew
