From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 29 Aug 2021 15:53:44 +0100
Subject: [v4 01/15] dt-bindings: iio: adc: Add ast2600-adc bindings
In-Reply-To: <DEB9D606-6489-4993-A5E7-6E4F3226EE5A@aspeedtech.com>
References: <20210823070240.12600-1-billy_tsai@aspeedtech.com>
 <20210823070240.12600-2-billy_tsai@aspeedtech.com>
 <YSTiUPQa+HYSA63t@robh.at.kernel.org>
 <DEB9D606-6489-4993-A5E7-6E4F3226EE5A@aspeedtech.com>
Message-ID: <20210829155344.370348d1@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 25 Aug 2021 00:06:47 +0000
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Hi Rob,
> 
> On 2021/8/24, 8:13 PM, "Rob Herring" <robh@kernel.org> wrote:
> 
>     On Mon, Aug 23, 2021 at 03:02:26PM +0800, Billy Tsai wrote:
>     >   > +properties:
>     >   > +  compatible:
>     >   > +    enum:
>     >   > +      - aspeed,ast2600-adc0
>     >   > +      - aspeed,ast2600-adc1  
> 
>     > What's the difference between 0 and 1?  
> 
> Their trimming data, which is used to calibrate internal reference volage,
> locates in different address of OTP.

At very least document that with a description: here to avoid anyone looking
at this later asking the same question! 

Jonathan

> 
> Best Regards,
> Billy Tsai
> 
>  
> 

