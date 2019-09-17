From: Rob Herring <robh@kernel.org>
Date: Tue, 17 Sep 2019 13:59:40 -0500
Subject: [PATCH v3 2/3] dt-bindings: serial: 8250: Add
 aspeed,sirq-polarity-sense.
In-Reply-To: <20190905144130.220713-2-osk@google.com>
References: <20190905144130.220713-1-osk@google.com>
 <20190905144130.220713-2-osk@google.com>
Message-ID: <20190917185940.GA4964@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2019 10:41:29 -0400, Oskar Senft wrote:
> Add documentation for 8250_aspeed_vuart's aspeed,sirq-polarity-sense
> property that enables to auto-configure the VUART's SIRQ polarity.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
