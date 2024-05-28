From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 28 May 2024 09:52:10 -0500
Subject: [PATCH v6 11/20] dt-bindings: i2c: i2c-fsi: Convert to
 json-schema
In-Reply-To: <20240522192524.3286237-12-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
 <20240522192524.3286237-12-eajames@linux.ibm.com>
Message-ID: <3c7fd737-c410-40a3-9994-282f214bad61@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

On 5/22/24 14:25, Eddie James wrote:
> Convert to json-schema for the FSI-attached I2C controller.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v5:
>   - Use more specific regex for node names
>
>   .../devicetree/bindings/i2c/i2c-fsi.txt       | 40 ----------
>   .../devicetree/bindings/i2c/ibm,i2c-fsi.yaml  | 76 +++++++++++++++++++
>   MAINTAINERS                                   |  2 +-
>   3 files changed, 77 insertions(+), 41 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
>   create mode 100644 Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml


Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>

Thanks & Regards,
Ninad

