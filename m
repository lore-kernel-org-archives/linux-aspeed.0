From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Jul 2023 23:45:36 -0700
Subject: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
In-Reply-To: <3756dffd-1407-d656-485a-9cf1eefd9ae1@linaro.org>
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org>
 <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
 <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
 <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
 <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org>
 <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
 <CAGUgbhCTDPGt_vpbfaEreX+iuLJ3WUBqt4kppxyaFZQus9Zf0Q@mail.gmail.com>
 <b22b2ccc-6760-0db6-067b-109c3864d2e8@linaro.org>
 <CAGUgbhDmXnyxYCL9h9C0P4ByDSTstWnGqW=uFoDVVHeK3BerHA@mail.gmail.com>
 <3756dffd-1407-d656-485a-9cf1eefd9ae1@linaro.org>
Message-ID: <28de46d5-bf6a-da0c-ad24-5404ad416b3a@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/17/23 23:04, Krzysztof Kozlowski wrote:

[ ... ]

>> The first method involves passing the memory region from an MFD
>> driver, which was the
> 
> I have no clue how can you pass memory region
> (Documentation/devicetree/bindings/reserved-memory/) from MFD and why
> does it make sense here.
> 

It is quite common for mfd drivers to pass regmap information to
child drivers. Child drivers typically call dev_get_regmap() with
the parent device as parameter. Granted, that is typically used
for spi or i2c devices, but I don't see why it would not work
here as well.

Then there s syscon, but I don't know if that works with overlapping
memory regions.

Guenter

