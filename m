From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Oct 2019 09:33:48 -0500
Subject: [PATCH v2 1/4] dt-bindings: interrupt-controller: Add Aspeed SCU
 interrupt controller
In-Reply-To: <1569617929-29055-2-git-send-email-eajames@linux.ibm.com>
References: <1569617929-29055-1-git-send-email-eajames@linux.ibm.com>
 <1569617929-29055-2-git-send-email-eajames@linux.ibm.com>
Message-ID: <20191011143348.GA22630@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2019 15:58:46 -0500, Eddie James wrote:
> Document the Aspeed SCU interrupt controller and add an include file
> for the interrupts it provides.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../interrupt-controller/aspeed,ast2xxx-scu-ic.txt | 26 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++++++
>  .../interrupt-controller/aspeed-scu-ic.h           | 23 +++++++++++++++++++
>  3 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
>  create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
