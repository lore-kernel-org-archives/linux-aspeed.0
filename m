Return-Path: <linux-aspeed+bounces-1102-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486BDC35FFF
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 07:28:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJvF92p7Rz30HB;
	Fri, 21 Mar 2025 18:28:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742542109;
	cv=none; b=KK7XXZq2Myiz5+0FhBZD1AST1DI7p7KxSsBNYsSZqypgUE9YuQ11KR9R8rf5RfI79l23ySMIf49z1pv/II/q2JFHYM9jvhyysBztRCfkqX/CHQA8WqOTdqPwpMDpNYTHeqfMTDW83akvVcEDtCfH+Tg3cMRvPMidM1T3k0um0FZ5riuyyjsWSGemPpiPi9gNBM6LIYxvzX+ryLVJ+iVtCeD9o+h8fJsMQyEv6NUpb+Js5fGA0x/Nfz3T8HVNw21TUNkaG8lRXl3bUBp3K8eDuKtsZZFNc1+ewEXjJCa1XTwcwrlySjAUb24UDfpDDCvNAJ6wVpUgJnwpy25Gd8i2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742542109; c=relaxed/relaxed;
	bh=ZB8kiE+qcLLJcoLITaaDs20vORJvN1XQTZkEg+RWu78=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bMA/vo5oe9yuZDq829EMXh9LgFXSeOXRSm8YQFiFFJx9K5hwIdIp/mABpw+IdanIaUNf1boD4cd1B3YUCqgp+xakBP6S/GhSFN8boEaCnSrpPtiGRkDf42MNiWmW6LuES9urXb0xIoV54dbH0lkINnnT4uejvz+QFR3faGAJz64/raxMh20BBP4AmHpegTyZf7GUIOTy+yg+Hscq740VIcyQdIf4ItgQxFh1VxUqX6gdky1zoFO+72ZsxGc8n6Eb5GZBRyzvLPlEN3ZRRFmgiftL3eI8cG1L7sYS0zaIHr8yGDnfaSa+pirRpGpX5vm/SqB5HBikoqqAKeFIb1UPLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gJEcrmGY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gJEcrmGY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJvF83smYz2yrS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 18:28:28 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-22580c9ee0aso33336385ad.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 00:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542106; x=1743146906; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB8kiE+qcLLJcoLITaaDs20vORJvN1XQTZkEg+RWu78=;
        b=gJEcrmGYPITgCvC4oapdQD4YemyBiVEvuDdyXMIWXF5rGJZy4jBasoOPoUqjjuuTyE
         9OS+ak/wTjReLeTbJVMR8NtjNh+M0EBPHvl1wlfeuTenD6CGATLeVW4GPYL7QRsmE2Qk
         +2SShUTNCGOzirbaJB6Oe+vGuQeksPNVrfz3dqmZdgLc6oRNhErjQo923usqPk2qdtOG
         dsnauM84qBRtFbhlfRRhgBlchgdm5edS0+eC0nGTMdWANAydLFa7Kh9jd2SkrlNEI+lh
         tTkJi2tsaZlzQkf1PcxDPdtlMHgh8L43ZUK1vSFzKVSLFBV/VDuNcTqfv/b0AebAylwF
         FVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542106; x=1743146906;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZB8kiE+qcLLJcoLITaaDs20vORJvN1XQTZkEg+RWu78=;
        b=Qae59xzNVbcKS8dvkNas/voXmK1JG935SPJCtO9chZdEp749dxb6IeSn6+4jqjzSdB
         ON5JlDK6fUwqvEnNUYnNxxyo4dqdWrNRyff6c+Y923Js69fA6i0ejYC0zub2B+IYbzv2
         EARuC59fDw2xGYqJZ4TpFPgC0Rn4r0lPrUZJV19M8zL/KRyjYQvz18oC4PT4xr9paGxT
         r81gSKqpzK4PpoggbKQFBXcsSrMDgBa9soE/Oj/QX6Alv3ApDQk6+s1HczzfiLnlbigL
         5uGE2aCi6seJfWGBAugsQyF4xwlWQF+HDq6Dx3s5rQecsyph+SEIr9d4FXnXAPITkOmP
         wsnw==
X-Forwarded-Encrypted: i=1; AJvYcCXR3Vbb1mLeT3EE5XaSL34n7gazd6UJO1mDi09IwxhsZL2VebrEtS46L/RQ4Z23zRPhxrEEEX+WlTTQbiQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyK/UYIUohFrV3eAvcIiwssz7gP7PfYhUiEyxaYtwUYC6UPJe05
	+zcvVEkXtJnAEZG6gqh0BCB9D751YY7yogkD4EFbOecC7EN6pfAX
X-Gm-Gg: ASbGnctAeSvzS7VC39T+4Lm2EzPin8lt7KVg1ASGUdIvmAVbDDPIugZSNDfY+l/ICUh
	F25FUhKAWljnZBGQpDNrKXMxkEIhUJ9QZvS7KokCuPHJ9XZYHDAMxuqWqgCqZTf/1OVtrHi3fAr
	kO4BTdR1SGtwLREvVL+Pb+ihlqPdnshQ4QEkhFDDmyfG9K1USxkav4eeJ/zY25z0r5zwcVTAbK+
	9rIHoyb6TKIQ9HxghftZxWekfTfPgkth1jjOxAq8/T2Aw/GnTUPwiXHhP6Btq4Nf5QPp7mV7d+y
	GWENxok87z+AWN5REYsCOCZv3D3+VBW32QPgBep2HCbeLue7WsSBQ1yCim51BxJeguFr9Owo5q6
	oxtZ6MZ1cVqtwz+CzP+zBcg==
X-Google-Smtp-Source: AGHT+IHlSEk8vePnKOkamFFIpfHyaA1m+UQS95Ubg2HRN1Dlu1q58w71hmeoIXSixkljxSV8yVTYSg==
X-Received: by 2002:a17:902:e884:b0:21f:8453:7484 with SMTP id d9443c01a7336-22780dae109mr29510195ad.30.1742542106449;
        Fri, 21 Mar 2025 00:28:26 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:26 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v6 00/10] ARM: dts: aspeed: catalina: Update DTS to support
 Catalina PVT hardware
Date: Fri, 21 Mar 2025 15:26:01 +0800
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIkU3WcC/5XNTWrDMBCG4asEraui0a/VVe9RuhjJ40SQ2MZST
 Uvw3SsH2hqv3OU7DM93Z5mmRJm9nO5sojnlNPQ17NOJxQv2Z+Kprc2kkEaAkHwcSup5xILX1CN
 vS+YfY4uF+O+LBx2ERR3agKxC40Rd+nyMvL3XvqRchunrsTnDev3h1RF+Bg48iODQSBW9bV7PN
 0zX5zjc2MrPckPCMVJWEpw0AK4jh35Pqi2pD5FqJbVvwGkdZEd7Uv+RSopDpOaCu6h0aEB5AXp
 Pmv+TppIEFgJZ0yh0W3JZlm+PDpfaIAIAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=2266;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=Nj94npq6q1wguoTxPUR60r+bZgVts+q6TMPv2OWz25Q=;
 b=O/AOrrLZgeC/5rmjqrKCnMKUbnnQpINPRqSIVmrM7UpVxmhshmQJ+PP052IxOx5ip+tGzT9l9
 JvIg8Q2vxwbAnO6gEvkWg8UYp1hBTjnq8UV9sZBTkW7igHFNpyMmbOw
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the DTS file for the Catalina platform based on the PVT hardware
changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v6:
- Rename the fan controller nodes with appropriate name
- Link to v5: https://lore.kernel.org/r/20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com

Changes in v5:
- Revise CBC FRU eeprom i2c bus and address
- Add MCTP support for backend NIC monitoring via PLDM over MCTP
- Link to v4: https://lore.kernel.org/r/20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com

Changes in v4:
- Split a single commit into multiple smaller commits to reduce complexity.
- Add `multi-master` into i2c12 & i2c13  
- Link to v3: https://lore.kernel.org/r/20250114-potin-catalina-dts-update-20250102-v3-1-14981744b2fe@gmail.com

Changes in v3:
- Remove delta_brick nodes due to compatible string not supported
- Link to v2: https://lore.kernel.org/r/20250113-potin-catalina-dts-update-20250102-v2-1-1725117fe7a9@gmail.com

Changes in v2:
- Add delta_brick nodes to support PDB brick board
- Link to v1: https://lore.kernel.org/r/20250103-potin-catalina-dts-update-20250102-v1-1-b0b7a523c968@gmail.com

---
Potin Lai (10):
      ARM: dts: aspeed: catalina: Add IO Mezz board thermal sensor nodes
      ARM: dts: aspeed: catalina: Add Front IO board remote thermal sensor
      ARM: dts: aspeed: catalina: Add MP5990 power sensor node
      ARM: dts: aspeed: catalina: Add fan controller support
      ARM: dts: aspeed: catalina: Add second source fan controller support
      ARM: dts: aspeed: catalina: Add second source HSC node support
      ARM: dts: aspeed: catalina: Remove INA238 and INA230 nodes
      ARM: dts: aspeed: catalina: Enable multi-master on additional I2C buses
      ARM: dts: aspeed: catalina: Update CBC FRU EEPROM I2C bus and address
      ARM: dts: aspeed: catalina: Enable MCTP support for NIC management

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 197 +++++++++++++++------
 1 file changed, 144 insertions(+), 53 deletions(-)
---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250102-potin-catalina-dts-update-20250102-914b06a4bdba

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


