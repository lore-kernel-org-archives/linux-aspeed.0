From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 16 Sep 2020 08:15:11 +0200
Subject: [PATCH v2 02/15] dt-bindings: gpio: convert bindings for Maxim
 MAX732x family to dtschema
In-Reply-To: <CACRpkdZXu2J4z=1j-syxSbz2x-QiLeTBpwHSOVNfmZ31RgM6Ng@mail.gmail.com>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-3-krzk@kernel.org>
 <CACRpkdZXu2J4z=1j-syxSbz2x-QiLeTBpwHSOVNfmZ31RgM6Ng@mail.gmail.com>
Message-ID: <20200916061511.GA5719@kozik-lap>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Sep 12, 2020 at 11:58:22AM +0200, Linus Walleij wrote:
> On Thu, Sep 10, 2020 at 7:58 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > Convert the Maxim MAX732x family of GPIO expanders bindings to device
> > tree schema by merging it with existing PCA95xx schema.  These are quite
> > similar so merging reduces duplication.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Can I just apply this one patch to the GPIO tree?

No, this requires the previous one (1/15) because it merges the max732x
into pca95xx.

Although now Rob reviewed both so you can pick them up.

Best regards,
Krzysztof
