From: Jamin Lin <jamin_lin@aspeedtech.com>
Date: Thu, 3 Jun 2021 10:48:18 +0800
Subject: [PATCH v3 0/1] dt-bindings-aspeed-i2 Convert to yaml format
Message-ID: <20210603024839.27976-1-jamin_lin@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Change review issue since v2
1. remove some description of properties
2. replace reset with resets
3. remove status from the example
4. move compatible first in the list of properties 

Jamin Lin (1):
  dt-bindings: aspeed-i2c: Convert txt to yaml format

 .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 75 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-aspeed.txt    | 49 ------------
 2 files changed, 75 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt

-- 
2.17.1

