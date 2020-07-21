From: Rob Herring <robh@kernel.org>
Date: Tue, 21 Jul 2020 10:13:17 -0600
Subject: [PATCH v2] dt-bindings: aspeed-lpc: Replace HTTP links with
 HTTPS ones
In-Reply-To: <20200720212110.64214-1-grandmaster@al2klimov.de>
References: <CACPK8Xc_iwvRtUVjY8G8rS8UbZf6-Q6FTGaNweJXk06A=Y459Q@mail.gmail.com>
 <20200720212110.64214-1-grandmaster@al2klimov.de>
Message-ID: <20200721161317.GA393067@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2020 23:21:10 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  v2: Left only links to be only HTTPSified.
> 
>  Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
