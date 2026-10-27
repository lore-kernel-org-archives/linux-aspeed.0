Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F032606A31B
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 Oct 2026 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BpSEP+oI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDGhQ6PPZz2yPG;
	Tue, 27 Oct 2026 14:49:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793072966;
	cv=none; b=oD0gSxyPSQ3+w1sghaMbj6z6xGUOjvY7rzQef8PpB+xWq0Ti2MSzTyuRueEx2uyu/EhIFSU1NyyrkTdQOzw6/7dtTDBRUjMS8UPcxEDdSAxTYbjhuGfMJD5j/akdxZ5QLL51x1hS6fsd8FrYWqQ5PzN5mmygEPWSK+rGBrBUK5oYvdXqBtGcHKrxM2WVHnB//WwdZjYkdU7DERRZw69Jwyl3zYQc9coZdyY6bUGlyLFxBEZEjJTGv0E6yTs3VUWBADnnfQnd6R54G1ninX4MKU4R0piyn4fTWisB+7DreAJCLGURgKfUhZsb1YqP1FR+Vuy226PEClpFu18GbfepAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793072966; c=relaxed/relaxed;
	bh=QYcOxOwG5nt64SzUuyibNRblxh48usRslX5qPY98KUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnDb+rHR88XzZfyhMjwMj9euw8wxF9nWzZilv9fnUXjhYYubgXSHjJU46BJBEDbBMROdNgizN0zXWAWGAWhKVelCo79je1aVYyeJ1TOjCMDqUJQF1k5iprSQCHx6yJa46jWqGL/gfeE+gozUxmSPo2Rqr+W3LZk0IFTlz63CA5LDv71ZNIs9lAxVnUviz6nM34iiU3k9QNgA47IsAXrQRKDbjnNzejJ4pgP2t104Z5pzrdcwmlNAMS0Uk5h/eVM6kmQ27cF2U5vvyxRraQQwIVqQSlMV+XTIgI2ZXuKApSSNt6I3CLybejm3hGviRVodsSsEHV8j39gDfKyUHCeZZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BpSEP+oI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BpSEP+oI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDGhP5NXDz2y2B
	for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Oct 2026 14:49:25 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-35c76e9614aso5845003eec.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 20:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793072963; x=1793677763; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QYcOxOwG5nt64SzUuyibNRblxh48usRslX5qPY98KUI=;
        b=BpSEP+oI7B371EnzTSOe2zvnNzknDf2fzORTdt+KyonTAxDWIX9nRBe9YHufE5XmWv
         QdOeGsbqWSqPhfkajgU87lTt0nlYRS15RUOnc2QKzFY/cUk8zSwruezFhk0gfEhW1JqM
         /UyWBHHnRGjMbB1oom/6qK14OtE34uSOAhHLo+y2nAVu/urFR8Ls4cfFCDugh1heNfhC
         dUQJyOslePpao2ogWD8ME2lU4dV6Z7dw1bVPHXd/lrHnbb/Yp1QrYrqbh1WSXH8ybA9A
         /Ico3GWvp4W94jOWhbC3QcDMB/Qsq7jLmNFjUxHAN2OAOuX8y0i8lhuO0BTEFVp339oE
         6Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072963; x=1793677763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYcOxOwG5nt64SzUuyibNRblxh48usRslX5qPY98KUI=;
        b=kKlKSqL3C56Su216MrQ90liQMxIe3AAsaeLx9fw7PrQuzwg6AkqtNXbaGmqRyv2aFf
         fXSqIhZzneuC1ZZOzn7Tja33P4cpcpnuygp7Wd3GxasyFMQMbp73LVFPzPolBamX5qdc
         38g6KHambBjVmEnopJXnzs7CnpkhlVGIzK5y6oNIlXHygCtTugaVuJWguoHISQKKkPEm
         T2paRtd6qEdVjqwn19ZawuSzhUuqJOLd9oX7ihnw+HX2qvxaBWxaZ2kl69PQMqoK2Jvq
         SEKHhX8ErR4C7lOrR/HO9Gth8lNsuLWOAnOpfHzovaFVT8+b7sZkEQBRvcsGtgT3OUI3
         eXiA==
X-Forwarded-Encrypted: i=1; AKwUvBx1Xv6iRjmIALYhIxnetShQDvewMC5Nx8/D7D1y4PJtV5GXnaSY+hZv0IiwXrCqZJhDl0RIpHOvlY98xOw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLoTbMd7EAaQeo10Cjht3iXWfpEJjdmbq+ecGHQ3e1Ro33R6q/m
	+JPJzRzRvXmZ1D+44MxxHZw3Liaza9vf/xFzL4SqX2bVDvrEyLImOoOw
X-Gm-Gg: AYBFou3p+wq9Z4hYZ6+VNdLrMY86svk/Mqan8TERpbZSs0TB2UFQJo3bYlg2MzE8gZX
	ym1J/RTxXtwQ4iKPSwsFZkoYEpNZolK0AOnHku0yEmtpkheQf5fWUfOk8k5Q7ZP6q648Ztp6ji+
	vl6TrsO83NIQNTBFihJqqne/IlrLW0h/4Zfd3+SXHu1jMUBqTjVcgGz8FyUmiskcNbWb40y0uRI
	+CqcTXHjBoCWpFcFxN3X+7r9+IaMnobqAcK8HP+FmcUz41UWYkf2Hbpgt8uN0KxXRGaQnV4gDnn
	ZqkN8MiBdXlzhSlqYoATul0wn6BXeLGaKJbBZuU3pWJylFuphDBU9AMTniSnVfWZIZycivafxeA
	ht1eoBj0DbYolxIwnsGy1ND8P9Fr5WTOrhQjYvH+y3wv2RKQUaq2pVWo8rrFyTMUACYHoQ8DYud
	CNHWEkKedT+H+C5HJyik2ANOjCZEkhdb1OFR5CSepMlHjD0N6LvugH2g8gbznknYcMB63hs6wfh
	FnBtE5rpGxKm/MaABa2rfLWjW9giQFSOMalC2IM8c3HYdXfXFFU6fgxdWN84che5MrZ1xcft7a9
	f8rcaVt8lqc3GFr0QZw57a+sTLxKM1bA4TgD8dOcy6Iu
X-Received: by 2002:a05:7022:f511:b0:1a0:5c85:d1b3 with SMTP id a92af1059eb24-1a05c85e6damr7103884c88.43.1793072962440;
        Mon, 26 Oct 2026 20:49:22 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.12])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5a515sm26430012c88.19.2026.10.26.20.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:49:22 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	andrew@lunn.ch,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v9 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Date: Tue, 27 Oct 2026 09:19:09 +0530
Message-ID: <20261027034911.99482-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the ASRock Rack B650D4U BMC, based on the ASPEED
AST2600. The series adds the board compatible and describes memory,
SPI NOR partitions, UART5, GPIO line names, GFX memory, the I2C7
EEPROM, and MAC0 with its RTL8211F PHY.

Enable both ADC engines with 2.5 V internal references and expose
all sixteen channels through an IIO-to-hwmon bridge. The channel
order is ADC0 channels 0-7 followed by ADC1 channels 0-7.

Changes since v8:
- Enable ADC0 and ADC1 with their reference settings and pin groups.
- Add the sixteen-channel IIO-to-hwmon bridge.

The other board descriptions from v8 are retained. Andrew Lunn's
Reviewed-by tag remains scoped to the MAC0 and MDIO nodes only.
Fan/PWM support and BMC-ready GPIO policy are outside this series.

Base: aspeed/arm/dt in the BMC maintainer tree
https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git
Base commit: 8db593481c8669eddb8b4e21ea44f3fa11d9f030

Validation:
- Compiled the board DTB with aspeed_g5_defconfig using
  arm-linux-gnueabi-gcc.
- Ran dt_binding_check for arm/aspeed/aspeed.yaml using dtschema
  2026.9, with no diagnostics reported.
- Ran CHECK_DTBS=y for the board DTB. No board-specific errors were
  reported. Two unmatched-schema diagnostics remain for inherited
  aspeed,ast2600-lhc and aspeed,ast2600-i3c-global nodes.

Hardware testing used the same ADC node configuration in a locally
patched OpenBMC image based on Linux 6.18.24. Both engines and the
IIO bridge were available; twelve configured voltage rails returned
readings, including standby rails with the host off. Voltage readings
also recovered after a BMC restart with the host reported on.

The complete DTS on this upstream base has not been boot-tested.
The tested OpenBMC image uses a different flash layout and separate
local power-control and sensor-discovery changes. Consequently, that
image is not a directly reproducible build of this upstream series.
Voltage scaling and sensor publication are userspace configuration
and are not included in these kernel patches.

The patches can be applied with git am on the base above. Anyone
boot-testing them should first adapt their image and bootloader to
the described flash layout; the DTB alone is not a flashable image.

Prasanth Kumar Padarthi (2):
  dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
  ARM: dts: aspeed: Add ASRock Rack B650D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 173 ++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts


base-commit: 8db593481c8669eddb8b4e21ea44f3fa11d9f030
-- 
2.47.3


