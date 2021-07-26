From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 26 Jul 2021 06:53:07 +0000
Subject: [v2 1/8] dt-bindings: iio: adc: rename the aspeed adc yaml
In-Reply-To: <20210723154456.00006744@Huawei.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
 <20210723081621.29477-2-billy_tsai@aspeedtech.com>
 <20210723154456.00006744@Huawei.com>
Message-ID: <E650AFD8-FFD1-4D87-87B0-42D20D9C3BB4@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 2021/7/23, 10:45 PM, "Jonathan Cameron" <Jonathan.Cameron@Huawei.com> wrote:

    On Fri, 23 Jul 2021 16:16:14 +0800
    Billy Tsai <billy_tsai@aspeedtech.com> wrote:

    >   > The aspeed,ast2400-adc.yaml not only descriptor the bindings of ast2400.
    >   > Rename it to aspeed,adc.yaml for all of the aspeed adc bindings.
    >   > 
    >   > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

    >   We try to avoid 'wild' card type namings most of the time and instead
    >   name after a particular part number.  I say try because clearly
    >   we let a few in over the years :(

    >   It is very hard to know if this binding will apply to 'all' future
    >   aspeed ADCs.

    >   As such I'm not sure this particular rename makes sense.

If I want to extend the yaml file to compatible more versions of the aspeed adc.
Would you suggest to add new files call aspeed,ast2600-adc.yaml or just append it
to the aspeed,ast2400-adc.yaml?

Thanks

Best Regards,
Billy Tsai


