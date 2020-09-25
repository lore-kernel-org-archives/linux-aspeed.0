From: Nishanth Menon <nm@ti.com>
Date: Fri, 25 Sep 2020 07:01:54 -0500
Subject: [PATCH v3 06/15] arm64: dts: ti: align GPIO hog names with
 dtschema
In-Reply-To: <20200916155715.21009-7-krzk@kernel.org>
References: <20200916155715.21009-1-krzk@kernel.org>
 <20200916155715.21009-7-krzk@kernel.org>
Message-ID: <20200925120154.utjxncf4qs2usuo4@akan>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 17:57-20200916, Krzysztof Kozlowski wrote:
> The convention for node names is to use hyphens, not underscores.
> dtschema for pca95xx expects GPIO hogs to end with 'hog' prefix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied to ti-k3-dts-next with minor update to $subject (added
'k3-j721e-common-proc-board:')

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
