Return-Path: <linux-aspeed+bounces-2857-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4396CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Nov 2025 14:34:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4sd32K1rz2xqj;
	Tue, 11 Nov 2025 01:34:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762785287;
	cv=none; b=NS28BVumHwotBSs28rkzYGBHfSAo8Knx0viee5Hf0uho7Gq8DUZ2EzN5KINwDjh0Nl3yv0vg9dSFvSR8zjM3PawfKzVIxL8bfXGARqds/1RoE6+pf9sKxRoNXSMj+WLasw3wu/dnjZvZARwvlH/Ps8ObWy7cYdxXacO3tRry7lz85Jr4z5Py7ARhBsjDbeDHU+liTp4VGtu6EX0sHCEC61r6Ov9bu1Kb0YDqst/JO6ZFeR4EQIZKutZ6msT/+nWuIXHZQlixq7FbHs5ZciVB+XsokTavfUYTe60UCuiGzA6Z78jfzwNTJzsKhu9Wl6VeXAuzMf7IRWGYoBeDVcXecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762785287; c=relaxed/relaxed;
	bh=SCCf38nnkWNjOJ81ZyYL98GTxpP0uUx/lAku/bbM36E=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GOmTWXT6ANsyfoJdvxIUKvUzJnd1iwToBEBo0KQa+1iKwC1b8ca1KNEjUOaC5YoIh+HP6c6+Jet/NccFORNXYB19scuTpgzreSeedEvSW5fWh7MgcpevV97GUVDUt5PGN8GoDbom2ACUw31lamoeNOTqCq1+CkdptsuKRFMdC3CX2tPGQqzSoUY0KWGMhuwczfE51gxLeo3zVUZo/AfLENN9XFXpjd5w8QZMBlmt6mEE9dKBNH5ewCMKTmI62sLl4zJSsOfp3w7zGRn9+6ovdyMBQsP6K1P/ICu0avjzg5r+WiBmdCWsOLjy1Zv0LE4IFwY3K+XqXFljXQr+iX8jeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WmKM6mky; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WmKM6mky;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4sd21mbVz2xqL
	for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Nov 2025 01:34:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 63AF5601BA;
	Mon, 10 Nov 2025 14:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92187C2BCB5;
	Mon, 10 Nov 2025 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762785282;
	bh=k/nZbTOGu0yXW0E7gJe16QIVdAo/xRXoYrYNFsxy19I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=WmKM6mkyfZO5xgAO/PWi8il6wQBeRwumaZXLjf12CWX7qVPePJsq+Du8caI65sGkN
	 SBIYG6GxaRD6FJlkiRsUyTZ2SxX+eYxL7qJ7+Aelr9RbGn+fFiYF0/uvl7+pUtDuFJ
	 CitvswaCnr78MwnFqdBGICZ4LJDVd0rcaaiKEPJ1OPJAc0DDe4GcESyly5kxCRIC3l
	 lRSKIOiO9I6rTIK/d14uQ75PvugBkTeHQvH7RLPG2RvbCP4orOiQ4uSjicdwaNtrVf
	 9nIO/KFdiWlvc41ZYqzhrACM7ApMDElMFdQvtOuyq/kcyE/RkL67jyilCr4Xcha9Fq
	 5sNCVbN2cZ/NQ==
Date: Mon, 10 Nov 2025 08:34:41 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 taoren@meta.com, Paolo Abeni <pabeni@redhat.com>, 
 linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
 Po-Yu Chuang <ratbert@faraday-tech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
In-Reply-To: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
Message-Id: <176278493665.154784.3408272608380491276.robh@kernel.org>
Subject: Re: [PATCH net-next v4 0/4] Add AST2600 RGMII delay into ftgmac100


On Mon, 10 Nov 2025 19:09:24 +0800, Jacky Chou wrote:
> This patch series adds support for configuring RGMII internal delays for the
> Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to
> distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration
> units differ.
> The device tree bindings are updated to restrict the allowed phy-mode and delay
> properties for each MAC type. Corresponding changes are made to the device tree
> source files and the FTGMAC100 driver to support the new delay configuration.
> 
> Summary of changes:
> - dt-bindings: net: ftgmac100: Add conditional schema for AST2600 MAC0/1 and
>   MAC2/3.
> - ARM: dts: aspeed-g6: Add aspeed,rgmii-delay-ps and aspeed,scu
>   properties.
> - ARM: dts: aspeed-ast2600-evb: Add rx/tx-internal-delay-ps properties and
>   update phy-mode for MACs.
> - net: ftgmac100: Add driver support for configuring RGMII delay for AST2600
>   MACs via SCU.
> 
> This enables precise RGMII timing configuration for AST2600-based platforms,
> improving interoperability with various PHYs
> 
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Po-Yu Chuang <ratbert@faraday-tech.com>
> To: Joel Stanley <joel@jms.id.au>
> To: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: netdev@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-aspeed@lists.ozlabs.org
> Cc: taoren@meta.com
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> Changes in v4:
> - Remove the compatible "aspeed,ast2600-mac01" and
>   "aspeed,ast2600-mac23"
> - Add new property to specify the RGMII delay step for each MACs
> - Add default value of rx/tx-internal-delay-ps
> - For legacy dts, a warning message reminds users to update phy-mode
> - If lack rx/tx-internal-delay-ps, driver will use default value to
>   configure the RGMII delay
> - Link to v3: https://lore.kernel.org/r/20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com
> 
> Changes in v3:
> - Add new item on compatible property for new compatible strings
> - Remove the new compatible and scu handle of MAC from aspeed-g6.dtsi
> - Add new compatible and scu handle to MAC node in
>   aspeed-ast2600-evb.dts
> - Change all phy-mode of MACs to "rgmii-id"
> - Keep "aspeed,ast2600-mac" compatible in ftgmac100.c and configure the
>   rgmii delay with "aspeed,ast2600-mac01" and "aspeed,ast2600-mac23"
> - Link to v2: https://lore.kernel.org/r/20250813063301.338851-1-jacky_chou@aspeedtech.com
> 
> Changes in v2:
> - added new compatible strings for MAC0/1 and MAC2/3
> - updated device tree bindings to restrict phy-mode and delay properties
> - refactored driver code to handle rgmii delay configuration
> - Link to v1: https://lore.kernel.org/r/20250317025922.1526937-1-jacky_chou@aspeedtech.com
> 
> ---
> Jacky Chou (4):
>       dt-bindings: net: ftgmac100: Add delay properties for AST2600
>       ARM: dts: aspeed-g6: Add scu and rgmii delay value per step for MAC
>       ARM: dts: aspeed: ast2600-evb: Configure RGMII delay for MAC
>       net: ftgmac100: Add RGMII delay support for AST2600
> 
>  .../devicetree/bindings/net/faraday,ftgmac100.yaml |  35 +++++
>  arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts    |  20 ++-
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   8 ++
>  drivers/net/ethernet/faraday/ftgmac100.c           | 148 +++++++++++++++++++++
>  drivers/net/ethernet/faraday/ftgmac100.h           |  20 +++
>  5 files changed, 227 insertions(+), 4 deletions(-)
> ---
> base-commit: a0c3aefb08cd81864b17c23c25b388dba90b9dad
> change-id: 20251031-rgmii_delay_2600-a00b0248c7e6
> 
> Best regards,
> --
> Jacky Chou <jacky_chou@aspeedtech.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: a0c3aefb08cd81864b17c23c25b388dba90b9dad (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s7106.dtb: fan@2: aspeed,fan-tach-ch: b'\x02' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: ethernet@1e660000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: ethernet@1e680000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [45] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: ethernet@1e670000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: ethernet@1e690000 (aspeed,ast2600-mac): aspeed,rgmii-delay-ps: [250] is not of type 'integer'
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml






