From: Rob Herring <robh@kernel.org>
Date: Wed, 13 Dec 2023 10:13:47 -0600
Subject: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
In-Reply-To: <20231212164004.1683589-3-ninad@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
Message-ID: <20231213161347.GA1204384-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 12, 2023 at 10:39:58AM -0600, Ninad Palsule wrote:
> From: Johannes Holland <johannes.holland@infineon.com>
> 
> Add a dt schema to support device tree bindings for the generic I2C
> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> Specification for TPM 2.0 v1.04 Revision 14.
> 
> This includes descriptions for the Nuvoton and Infineon devices.

This is incomplete and conflicts with this series[1]. Please help 
review and make sure it works for the cases you care about.

Rob

[1] https://lore.kernel.org/all/cover.1701093036.git.lukas at wunner.de/
