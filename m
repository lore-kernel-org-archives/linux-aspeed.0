From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Apr 2021 11:00:19 -0500
Subject: [PATCH v5 4/4] dt-bindings: serial: 8250: add aspeed, lpc-io-reg
 and aspeed, lpc-interrupts
In-Reply-To: <20210408011637.5361-5-zev@bewilderbeest.net>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-5-zev@bewilderbeest.net>
Message-ID: <20210408160019.GA1555403@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 07 Apr 2021 20:16:37 -0500, Zev Weiss wrote:
> These correspond to the existing lpc_address, sirq, and sirq_polarity
> sysfs attributes; the second element of aspeed,lpc-interrupts provides
> a replacement for the deprecated aspeed,sirq-polarity-sense property.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
