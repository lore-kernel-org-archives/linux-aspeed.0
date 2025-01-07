Return-Path: <linux-aspeed+bounces-342-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D92E77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 18:22:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSKCk6h0Bz2yJ5;
	Wed,  8 Jan 2025 05:22:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736274162;
	cv=none; b=cNXGWWyoDkES9tSPW5v1nSmq3mHxa5m226KiZ7avsCW8ob7XW/uW7KpGG3Ngxc4isC1Zck338aVyhnaffZ6DIgKSE55bQoYaOP1pDS8y5jvQ/kQUu0tBY7Wh4lFe1izUxH2lc0aJj8eYTTrxOP4Q/4wkw6zbe6fXxjFz1bIghZBoIMKdTX97nJt6Nhgdp9DB9lc58ciiLaIZFSL0fAtr8vpQh95vvo90ZHM3m/A1NB1eSTbKmm8HFBDgL+v7Rma2qeOGwW1e5xOmwRNvu2EKTw1GT1MiBWdbeGxTjNXQzH9kfSqa8UVc229olweG2gnCdIf9dD5Dt72Lb4lhzxIS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736274162; c=relaxed/relaxed;
	bh=/gkFFLzzDG1L/33tUrIZ7IbRLBj2EoYvSSWS8ENRDhM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=fYWEIE9H4vPpHgwqS2+89ZOuWxCjXHegjZbTIa41P6nm5NVZFGRXCujZJSVFLfsFnlvv+6KCNTFWAgypoMrZTpzkjU8UV4Qkp1ERyw806eCe8JDbT0Wd9DmUpPsD+COvb35GzMyEYeWtYOoE99rIEtDTI1u4OrEdzmj9AlzGBMOVHwh1YSGLjCvQvw3FBJ4u7jQYmqEBJeEEk0TmlBBjbYbOeotBDfTbPlXn74CkQraVvV1NLBmQ4kGCAt3DUYd+7zmYv1NmQYQO/h+uuKARPdU+EIsFrbYBSIaBzbl8MhEQV2Gw9LI4thT/dkTIcIwaYLu9+MAlbzHL6Nh4Zkqy1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y8Uox00V; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y8Uox00V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSKCj4xXkz2yFD
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 05:22:41 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 85225A41B86;
	Tue,  7 Jan 2025 18:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A9DC4CED6;
	Tue,  7 Jan 2025 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736274156;
	bh=nQt0n0t3yZF3lcbbDEr06Sl/D9a0HeRqKxRgtUlA08I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Y8Uox00V0JqdR041OQIfsDcEnXxckrrsxU+9GwVzlDW75rqIbyuwc/gSpA/1JFEws
	 3ILKwoSAbMHiK6q+Iy3iIFE2ZQjba3dsgC4QqqMM75IE6xzfd4M60L6bnC9h1XIFg1
	 813GljNv7DbP7qomTalL0jq0xCVsBLhgbGSYgF/KDvjt0AHRm8tCZ6XbXBp4b9pbvd
	 0S3rmZzcpycYu2LROF9Acl6tOjSoiztCEzw3vhQ5m4VNcIiys9FUBjEUb9q5YIH1Zt
	 33dBBdWB559MFABnYDCYlXp9p6tO0t2X3CPRa02N8NhghE31+7ZQlMaOfWcirRZxuC
	 tIbd6/eNeyYsw==
Date: Tue, 07 Jan 2025 12:22:35 -0600
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
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: eajames@linux.ibm.com, linux-aspeed@lists.ozlabs.org, 
 netdev@vger.kernel.org, kuba@kernel.org, minyard@acm.org, joel@jms.id.au, 
 andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 davem@davemloft.net, krzk+dt@kernel.org, conor+dt@kernel.org, 
 ratbert@faraday-tech.com, pabeni@redhat.com, 
 openipmi-developer@lists.sourceforge.net, edumazet@google.com, 
 andrew+netdev@lunn.ch
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250107162350.1281165-3-ninad@linux.ibm.com>
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
 <20250107162350.1281165-3-ninad@linux.ibm.com>
Message-Id: <173627415580.1273439.8070481995690256439.robh@kernel.org>
Subject: Re: [PATCH v2 02/10] bindings: ipmi: Add binding for IPMB device
 intf


On Tue, 07 Jan 2025 10:23:39 -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface driver.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:21.17-30: Warning (reg_format): /example-0/i2c/i2c@10:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:18.13-24.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for I2C bus
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:18.13-24.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for I2C bus
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:19.20-23.15: Warning (avoid_default_addr_size): /example-0/i2c/i2c@10: Relying on default #address-cells value
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:19.20-23.15: Warning (avoid_default_addr_size): /example-0/i2c/i2c@10: Relying on default #size-cells value
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250107162350.1281165-3-ninad@linux.ibm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


