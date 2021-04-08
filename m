From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Apr 2021 10:59:06 -0500
Subject: [PATCH v5 1/4] dt-bindings: serial: 8250: deprecate aspeed,
 sirq-polarity-sense
In-Reply-To: <20210408011637.5361-2-zev@bewilderbeest.net>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-2-zev@bewilderbeest.net>
Message-ID: <20210408155906.GA1553685@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 07 Apr 2021 20:16:34 -0500, Zev Weiss wrote:
> This property ties SIRQ polarity to SCU register bits that don't
> necessarily have any direct relationship to it; the only use of it was
> removed in commit c82bf6e133d3 ("ARM: aspeed: g5: Do not set sirq
> polarity").
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
