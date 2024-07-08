From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Jul 2024 07:47:30 -0600
Subject: [PATCH v6 00/20] ARM: dts: aspeed: Add IBM P11 BMC systems
In-Reply-To: <20240522192524.3286237-1-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
Message-ID: <20240708134730.GA2916637-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 22, 2024 at 02:25:04PM -0500, Eddie James wrote:
> Add the Blueridge and Fuji BMC systems. Document many missing FSI related
> properties, and fix existing warnings. Make some minor fixes in OCC and
> SCOM drivers for the updated bindings.
> 
> Changes since v5:
>  - Switch from clock-frequency to bus-frequency for common FSI controller
>    properties
>  - Add reg properties for AST2700 FSI controller
>  - Fix patternProperties for i2c bus nodes under FSI-based I2C controller
>  - Add bus-frequency for P11 FSI device tree node
>  - Change model name from Blueridge to Blueridge 2U
>  - Add missing reset gpio to led controller on Fuji
>  - Add Huygens (Rainier with modified FSI wiring)
> 
> Eddie James (20):
>   spi: dt-bindings: Document the IBM FSI-attached SPI controller
>   dt-bindings: fsi: fsi2spi: Document SPI controller child nodes
>   dt-bindings: fsi: Document the IBM SCOM engine
>   dt-bindings: fsi: p9-occ: Convert to json-schema
>   dt-bindings: fsi: Document the IBM SBEFIFO engine
>   dt-bindings: fsi: Document the FSI controller common properties
>   dt-bindings: fsi: ibm,i2cr-fsi-master: Reference common FSI controller
>   dt-bindings: fsi: ast2600-fsi-master: Convert to json-schema
>   dt-bindings: fsi: Document the AST2700 FSI controller
>   dt-bindings: fsi: Document the FSI Hub Controller
>   dt-bindings: i2c: i2c-fsi: Convert to json-schema

Looks like these haven't been applied, so I applied patches 2-11.

>   dt-bindings: arm: aspeed: add IBM P11 BMC boards
>   ARM: dts: aspeed: Add IBM P11 FSI devices
>   ARM: dts: aspeed: Add IBM P11 Blueridge BMC system
>   ARM: dts: aspeed: Add IBM P11 Blueridge 4U BMC system
>   ARM: dts: aspeed: Add IBM P11 Fuji BMC system
>   ARM: dts: aspeed: Add IBM Huygens BMC system
>   fsi: occ: Get device number from FSI minor number API
>   fsi: occ: Find next available child rather than node name match
>   fsi: scom: Update compatible string to match documentation
