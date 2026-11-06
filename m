Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3355606A331
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nzSqLiy8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLPBw1kWgz2xH7;
	Fri, 06 Nov 2026 14:03:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793934216;
	cv=none; b=X+RIG+FlWF/MnpVgDjIbtzhZh4qEd26OuUR3mK9o1FWLc4LuIx8J/HzHoseGkQpWg+0E1s0MhSEkN3p82HJqBkyoE6CkTS0tySqVU0Fmlswh3S8OXwrqQGwzttMCt4IWGOW+r8igivpAMjPpA1CnU4vmf/d6IXkKW+opRl4NXF1I6QXzVbRxJCPS8Nj9cTdwcGEu0UU8/605khilxCfsGFUHEnO2/G2Cd9qjpXlpKaN8BSKdzahNb9ONPWl1m7KpfF/l4VZ5Nvbc5uUU3EHSWg+xgb7JYZsQw7fTvMhmOMkBaCEIAFtqtr9cktpMBHVEIvji6svQj763VvSHIMfdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793934216; c=relaxed/relaxed;
	bh=ASBwV8LCp1C0yRJR8yBz3HjgWmYNCn4cK28x1+h41Lw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SgK1TqtDCV+AD1fX9+Dl9Id8ZiYkDr0RD0u7j2B79QzS0+4ADtTtBKXH8zW+438IYN9cljhBsTtgQzHjb+5JITojJLqujLAiscPD79UB6p6ou/gCP8jr1RhOIGqeejqgz38n6i9Wy53D1pIJ7ch30MzG+mf0Per3J2WaOvTbSndKw8iKhsLYq5R1TSyqIMcRMNf+c9o3iQEabkRFFc6J0Tw009pOajHmtQvPzi11XeJ7Z/8EYiAlnJJPxRjlAeocBUknMswwiD6oqaqRsux4joBQv3qXWpVELe4IxTU47LtE31u7stUDzyoxjw11/Zp2er11U2RZykpsOAW/zECr9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nzSqLiy8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nzSqLiy8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLPBv4Kg0z2xGr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 14:03:35 +1100 (AEDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso67541a12.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 19:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934213; x=1794539013; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ASBwV8LCp1C0yRJR8yBz3HjgWmYNCn4cK28x1+h41Lw=;
        b=nzSqLiy8faXSOIqy2Z5gOQuJKqjtaS0LEgQ1kxCPNeek9hshUU7Zynf+zJyx8Hyw+0
         Ihrhrh1fI7MEgdy2fzeJwzm4GdGvQ7U9JSp3QUDGiNCdwVwQPNtPNuUIH+OtdwEH2bPU
         6q2cKymwMiHSNEOV1yoeMVH6B3/TPPpqanMSitC9kohRqIaPkd0JZ+/sQHgAOVyWisQp
         9e+GUE9lnYTWoWIS45ftsyXB07KKPVn3UBcLJtH3te68Dk6i2Z4UlKeIm9OYDXMeJE9H
         A8t0oSSx6V8FKOoPlw9Do5jX37EEDuB8bGOTUS/VNxo5ih0IuoN8jHSTjwRuLhHdfjKx
         O0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934213; x=1794539013;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ASBwV8LCp1C0yRJR8yBz3HjgWmYNCn4cK28x1+h41Lw=;
        b=HmKgqmEuRMv9Fgaxx11dNNvv9vm+SoFJmYekb9n86872GaX3CY3wZN1Nv8WYidk8oz
         SUFlGOCjMletE9xNCAOUjcuZAiNkeUnBc52QkwHIn5Ibz75IIbOGL8dNVovyJ3yuIeeN
         6X3Lm25hoy1vnz2wD3I+fED8in3Hn20FRBzHe5nRczWEkjuznT1vMuwyu/HYMzp9jBtO
         +fio8CwfjHnQFIFEl0k5M2SzVAUiN/jKxwR9AL9Z60PsmTwdFHSXhH5S3Q1irK4bSa4V
         MX7xA9JSu9MQcp0a6hztmw4fM2JRIjirxHBcu1uR2YSCU1yxLTiixm2VnyWu9g5xhDwJ
         0vtw==
X-Forwarded-Encrypted: i=1; AL+hErGT82sxdRdd5OzPu8uLq9/gAK9JaOmDFPa7uH8p/qh8Bgus5smG9NbUqvTz01BrFUeRSVvRbwye7v5KLJo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/T8/x37LHRX5Tf/YMkUEdc1fd5h9wBpZrtm4vK5dKFDRzdkNPx
	VeSAmpkAyTylhU/Z8WGXoIc7P2iiFPW3W8M+ftWeh0DSUziNS1RhpRbN
X-Gm-Gg: AYBFou0ljtqta73oAXSL51/f5G4GeuPtX7dmx1JVPQGdJXgOwXYwMaZb3s+w2A0VvX7
	gUjrVf6NxHfqqZ6E6JANoKJiSGs4aRpVy6F0iWwVYAqoPNJ7U3SC9Z9Jvkoay7h6MXnhsZTwU/5
	ASIQRynN9SioiGD51OHzqoe5d9vQHcsHk8NjOlJJbjJuR/A5z9M9Bl8sTw1pWxinRP0lYfUSGY8
	Gg7Qa2RnglABpLC8NwEWX0VfyNV6q4Go4vJ2fGMRx4LLDiAq3QySmxfXrEMlXgHnBf5ux96w+ZD
	kXTKUWAxl/aKlOFSBQhkquqZi4ORziX47pjT0iuOdHf/CnRvyjQv8t94Sn9exjjiTn7PnnL7ULJ
	n7qq7Jvw7sGsU6Gq8ST7qTvBnPULML9blA6q+swdxcrihWdQpWT+nI9VUM7B52YZfDIMUD5vbKE
	Cg2LGMHSX7HeanV266/4RMdp6WBkKBgzSOzqIPlcV6V5qjhpKgHYwnrXZ50+HBPXS5tHtfCUkr0
	A8FU6jGFvzMpXDkTa8eIMoV3QIV2WWjYokKqAwlVUIbN2lSnoAb08GAj0xJUJe5dPyaBP+Sa2lV
	xFgU2qYa7IT9Yc/dzYBfaHqfRs0pKUquc+CCBJAjD35ahN/4Twzrw0+rdZAUqkaT3TJG
X-Received: by 2002:a17:90b:580b:b0:3aa:f4af:1e16 with SMTP id 98e67ed59e1d1-3b0db5f1545mr1108730a91.7.1793934213421;
        Thu, 05 Nov 2026 19:03:33 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a04a39sm118179a12.15.2026.11.05.19.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:03:32 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH 0/3] ARM: dts: aspeed: ventura2: Add LTC2305 ADCs and GPIO
 line names
Date: Fri, 06 Nov 2026 11:08:01 +0800
Message-Id: <20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJFE7WoC/x3MPQqAMAxA4atIZgNpwQ5eRRxaGzVLLf1DEO9uc
 fyG9x7InIQzzMMDiZtkuUKHGgfYThsORvHdoEkbpchg41Bqshp9yVijt4VxJ3IbTYqcdtDLmHi
 X+78u6/t+L/W3CmUAAAA=
X-Change-ID: 20261106-ventura2-dts-update-f00bc0510b2b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=lolMIAz2iXzBafL/lg43sfocr/VCB+03ulE0SYBkY9w=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq7USVOT8QeKuwr2nO937gkCr2m3czU+Kauuu5R
 Ff/aIhYg0iJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCau1ElQAKCRClg0K3CVbE
 gSf8B/oD1Abx+lgUrMKZp4jqZ4rjfgY7XYOnLkKCQ+AcALPfduyJpsZtMbx22AX5KN7PzEfQHAA
 Q/SfNl0TNPYfvUrUY9jUMgDnO2Q4tmpGbYnknhRIhO74j83UJE6qZtY6ysbkRBXyAO80TDR69al
 QoCoo5LgWgHJFakOvIAssoBw1hLpXHVf9rZOLBp0vNML9TG5qTy1zyzhm8bgi15lHbyGh1ddT7t
 74jl3hmLFNxdocqFABdW5mmyXJiASzCHyGk0qj46Q62UgfFppPcNSagfBYWBcpjCnQtjEcDXyrJ
 E1PXGhN1Gkjzahj/sAwoDUy9ljzq0acArWGGeWU+98BbEuW1
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series is a follow-up to the Ventura2 devicetree.

Patch 1 describes the three LTC2305 ADCs fitted on Ventura2 and exposes
the valve voltages read by the bus 3 ADCs through iio-hwmon.

The LTC2305 ADCs use their internal 4.096V reference, so no vref-supply
is described. Patch 1 therefore depends on "dt-bindings: iio: adc:
ltc2497: Make vref-supply optional for LTC2305/LTC2309"; without it,
dtbs_check reports a missing vref-supply for the LTC2305 nodes.

Patch 2 names the presence detect GPIO of the optional COM Express
module so userspace can determine whether the module is present.

Patch 3 names the reset GPIOs of the three USB-to-UART bridges so
userspace can reset the bridges.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Kyle Hsieh (3):
      ARM: dts: aspeed: ventura2: Add LTC2305 ADCs
      ARM: dts: aspeed: ventura2: Name the COMe presence GPIO
      ARM: dts: aspeed: ventura2: Name the USB-UART bridge reset GPIOs

 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 36 ++++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)
---
base-commit: f4dcbba2ec358f7079daddcda7594dad9746326a
change-id: 20261106-ventura2-dts-update-f00bc0510b2b

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


