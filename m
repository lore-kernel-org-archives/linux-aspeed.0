Return-Path: <linux-aspeed+bounces-3786-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F633109E558
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 06:47:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDqH6s2Cz2yS4;
	Thu, 26 Mar 2026 17:47:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774507659;
	cv=none; b=V9Oq86u9z/ftBXFFZ1hrP9MKIKoMLBpajay3N9/9unAjOQ7DtVQ3Kzb4nM8oC47GeWR2riZRIpTxXS/zFQ+qOH8oNcXFyz55jIxPpZR2CnJn29Xz13LtyrrBxfKk4jUVnz9+98eu69bgg3TXmSPAOphDZVWzn80gJA5zdLo3cTzB8Z8n0X0raBhBiBG7hiQaNl18kXOmyEqlZxvjk+ja/6puP4DsbDTkwZEJoRDYF4uqn36WPRM3pf9iwxka5B3scXR2/9nGvv44c5rUwksl38rI47QTdjnCk4uwEbXYSZxHREkv7+J0UwKU+X0XBeC9kv3LNyomncu+0O8RuAgmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774507659; c=relaxed/relaxed;
	bh=uuO89bXipoojZ5oWacJBzynhJDJvNYok686rks33Smk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b3EFtKYgi+x1A65C2ALs0wafLmJ5EFMQDW9e6WZMWTt51aJFtYAieM0cJqtjow0YSMSC3C96+bcSqoauVjBsyCgGSzHfBWPVZOg5sCr5awzcsbp4ehil23F94WqhOL4cyrJ5WI0qttgjvZstb2Dvv3nx5xGKgkpYNlz9bOtNCm1Az+sfmFShp7xpyjKbvfbz5W6aoq3YdxBQculkSJYvnw4ac3in+EfXiLaMq2sW0r3ypjoCNBp7ocvnOOOEtqW8nglh1FWyFvSPo3yeeR0vb08AfTMVXs0112ANZRmliS2SduqxA1lvkjc6GVc/x3q4+S6OvAsIqR+ZmqvG67VAyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=fffD0qEu; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=fffD0qEu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDqH3dGHz2xS5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Mar 2026 17:47:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774507658;
	bh=uuO89bXipoojZ5oWacJBzynhJDJvNYok686rks33Smk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fffD0qEuIDRqpi3IHyTr1aG2sgjzLTaVV/UVnCDIyZWhOuB7eKGFM/IbMty8f1BcA
	 WxjANSn/Wubl97tUOZ7iF4u2fp2jci6qESwk21xqNHtXV1jjTcb5GjE+0+HNzYo5re
	 WcYlzN0gK08wg0l/1hZpaX4AxJIMgvqDl0xYLYDbL/0ueBuR9ykaosOS/whUWyqCuC
	 gG8bX0VYwm6mmMfgH32Rl9UEGH0oBK2jDbAj5UE5RTJxeXyQnmxumvh6jIyRdeJNJ9
	 mbKrv0yvPsxztFkwOmHiMoplqOtepCX4m5HVeMflE+4JtJMqcIVYFzmjf558OvQp7w
	 77ZMuKGa+oyrQ==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 21ABA6597C;
	Thu, 26 Mar 2026 14:47:38 +0800 (AWST)
Message-ID: <8e93868a7f15596f1ee2b758d1743b51d6491486.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 0/2] Add Meta (Facebook) SanMiguel BMC (AST2620)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Cosmo Chou
	 <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, Potin Lai
	 <potin.lai@quantatw.com>, Conor Dooley <conor.dooley@microchip.com>
Date: Thu, 26 Mar 2026 17:17:37 +1030
In-Reply-To: <20260311-sanmiguel_init_dts-v3-0-2b4d1ab7a8a1@gmail.com>
References: <20260311-sanmiguel_init_dts-v3-0-2b4d1ab7a8a1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Potin,

On Wed, 2026-03-11 at 14:19 +0800, Potin Lai wrote:
> Add Linux device tree entries for Meta (Facebook) SanMiguel specific
> devices connected to the AST2620 BMC SoC.
>=20
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
> Changes in v3:
> - Update the model name to "Facebook SanMiguel BMC".
> - Remove CP2112 and downstream IOEXP nodes as the upstream driver
> =C2=A0 is not yet available.
> - Remove the following EEPROM nodes until the bus numbers and
> =C2=A0 addresses are confirmed:
> =C2=A0 - 3-0051: HMC FRU EEPROM
> =C2=A0 - 3-0052: HPM0 FRU EEPROM
> =C2=A0 - 3-0053: HPM1 FRU EEPROM
> - Change the compatible property of the following EEPROM nodes
> =C2=A0 from 24c02 to 24c128:
> =C2=A0 - 5-0050: SMM FRU EEPROM
> =C2=A0 - 9-0050: PDB FRU EEPROM
> =C2=A0 - 13-0055: SMM EXT FRU EEPROM
> - Fix the smm_temp node address typo (0x4e -> 0x48).
> - Remove nodes that no longer exist in the latest board design:
> =C2=A0 - 19-006f: RTC (nct3018y)
> =C2=A0 - 9-0075: IO expander (pca9555)
> - Update linenames to match the reference design:
> =C2=A0 - B0_M0_AIC_USB_EN-O -> B0_M0_CPU_L0_RST_IND_L-O
> =C2=A0 - B0_M0_BRD_ID_2-I -> B0_M0_BMC_TO_GPU_MCU_I2C_EN-O
> =C2=A0 - B1_M0_AIC_USB_EN-O -> B1_M0_CPU_L0_RST_IND_L-O
> =C2=A0 - B1_M0_BRD_ID_2-I -> B1_M0_BMC_TO_GPU_MCU_I2C_EN-O
> =C2=A0 - IOX_GPIO_P16_TP -> USB2_BMC_HUB2_RST_L-O
> =C2=A0 - I2C_PDB_ALERT_L-I -> X86_TPM_RST_SEL_L-O
> - Remove unexpected or unsupported properties from SSIF and IOEXP
> =C2=A0 nodes.
> - Change all status values from "ok" to "okay" for consistency.
> - Link to v2: https://lore.kernel.org/r/20260203-sanmiguel_init_dts-v2-0-=
6a5682c32b38@gmail.com

Can you please discuss these proposed changes in the context of my
reply to Kevin below?

https://lore.kernel.org/all/d7794f74b26bbc1ee0a70e39c5671acc018f80eb.camel@=
codeconstruct.com.au/

Thanks,

Andrew

