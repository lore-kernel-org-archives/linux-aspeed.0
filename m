From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Mon, 12 Sep 2022 10:58:10 +0000
Subject: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
In-Reply-To: <2c44a497-b489-7519-e922-4ec79eb7617d@foss.st.com>
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
 <2c44a497-b489-7519-e922-4ec79eb7617d@foss.st.com>
Message-ID: <118c2b49-fefd-7de6-5b0f-9ae4064c7b56@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/12/22 12:44, Patrice CHOTARD wrote:

Hi!

>> -             /* 2 bytes per clock cycle in DTR mode. */
>> -             op->dummy.nbytes *= 2;
>> -
> What is the benefit to remove dtr dummy.nbytes computation ? it leads to spray it in all drivers which support DTR.
> It was simpler to let the framework to deal with it, have i missed something ?

The majority of drivers from SPI need the number of cycles, not the number
of bytes. JESD216 refers to dummy ncycles as well, there's no such thing as
dummy nbytes. You'll notice that these drivers do the computation back to
ncycles in their driver, thus they undo what's prepared in SPI NOR. There
are just 4 drivers that use nbytes and rely on what's currently computed in
SPI NOR. Since these 4 drivers don't use the standard parameter and require
nbytes instead, they can do the conversion to nbytes in their driver.

-- 
Cheers,
ta
