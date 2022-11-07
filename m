From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 7 Nov 2022 02:34:51 +0000
Subject: [PATCH 1/2] iio: adc: aspeed: Remove the trim valid dts property.
In-Reply-To: <20221106144949.61731d8e@jic23-huawei>
References: <20221031113208.19194-1-billy_tsai@aspeedtech.com>
 <20221106144949.61731d8e@jic23-huawei>
Message-ID: <16211538-3501-4A32-96B5-1AD1BF933CA5@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2022/11/6, 10:50 PM, "Jonathan Cameron" <jic23@kernel.org> wrote:

    On Mon, 31 Oct 2022 19:32:07 +0800
    Billy Tsai <billy_tsai@aspeedtech.com> wrote:

    > > The dts property "aspeed,trim-data-valid" is used to determin whether to
    > > read the OTP register. If the image with the aspeed,trim-data-vali
    > > install to the chip without valid trimming data the adc controller will
    > > become confused. This patch use the default otp value 0 as a criterion
    > > for determining whether trimming data is valid instead of the dts
    > > property. The chip with actually trimming value is 0 should be filter out.

    > Hi Billy,

    > I'm not sure I correctly follow the patch description.  Would the following
    > be an accurate description?

    > The dts property "aspeed,trim-data-valid" is currently used to determine
    > whether to read trimming data from the OTP register. If this is set on
    > a device without valid trimming data in the OTP the ADC will not function
    > correctly. This patch drops he use of this property and instead uses the
    > default (unprogrammed) OTP value of 0 to detect when a fallback value of
    > 0x8 should be used rather then the value read from the OTP.
Hi Jonathan,

Yes, it's correct.

    > Also, is this a bug fix we need to backport?  If so please provide a fixes
    > tag.

I will provide the fixes tag in next version of patch.

Thanks

Best Regards,
Billy Tsai

