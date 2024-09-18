From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Wed, 18 Sep 2024 17:54:33 +0800
Subject: [PATCH v2 0/3] yosemite4: Add power module and ADC on Medusa Board
Message-ID: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changelog:
  - v2
    - Add pmbus compatible string in trivial-devices.
	- Add mp5023 compatible string in trivial-devices.
  - v1
    - Add power module and ADC on Medusa Board.

Ricky CX Wu (3):
  dt-bindings: trivial-devices: support pmbus compatible string
  dt-bindings: trivial-devices: support MPS MP5023
  ARM: dts: aspeed: yosemite4: Add power module and ADC on Medusa Board

 .../devicetree/bindings/trivial-devices.yaml  |  4 ++
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 45 ++++++++++++++++++-
 2 files changed, 47 insertions(+), 2 deletions(-)

-- 
2.25.1

