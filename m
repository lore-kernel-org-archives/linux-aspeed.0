Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8AE606A31C
	for <linux-aspeed@archiver.kernel.org>; Fri, 27 Nov 2026 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q3tKJNQL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbJ6T0d4hz2yCR;
	Fri, 27 Nov 2026 13:59:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795748369;
	cv=none; b=mqa6MF9Lxe/gkZ6C0dNYeK5+lq1oAYZmvl+SXp4oWtgW9YZci7zDShNQVhLlm3Rrw63GzVkO0X7mYWMFOF5g7UzS+26t3A7zNljfCNt6L8d7p4ikftbH7HgTZ4VoZCOjDLLMU1kj/5UAEA04Ec+ZxDZDTXhoiGJ3EC54Y+Q+A+ZzE3E1bGRv8CV6CE4tI+Jn7iQAO6JXJXa4N3G++FiV/j96/ksFK6JKWO8CKe6NqGwwXzVCOmT1GdxkIhR/4omgVZPw/Pv1qsPuV4lbAl5N4fuov5f+99yV3kucCnpsyJdmNxFCBZJHChPjmk/OxshZux1nh87qv8hnMDs9JZb+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795748369; c=relaxed/relaxed;
	bh=Vk8QAimfppOVA6mWM6XoEd6S6tNQdHOsmJkxKjoB4U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uy612hz2S0+e9g3Mm+jC5wP+VjiG8jTl7Bg+lexwlxQzsNqzZO5tkYy1mcIpDh9NhX3/xkHVYT4J89WOXKJJfgD9tDIVU7p2qnVAtvDTEqJgszVLoY0Y0Z4lxNb4yiQNUai3s/Pjg+FQ7V10l/KzphRWHzP4pMVKdI1mL8F6vfRFtmXN1i+fD9/f7pbkWeg1oiaa+KcfvJBe4YxqwolTurBDhq9XXRsyAlGgqe6wtOlF6jErO6n2ZqlodiCXO3hwHTZfCq88xKJqep02i90Nh+3aa666XRhByM1Nb12zK3ypqgRDle2YQecaYSSmVwFD1BPeSax6W3RIu1F3Jy7u6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q3tKJNQL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q3tKJNQL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbJ6R6Lwxz2xLs
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Nov 2026 13:59:27 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-38190551625so14629839eec.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Nov 2026 18:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795748366; x=1796353166; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vk8QAimfppOVA6mWM6XoEd6S6tNQdHOsmJkxKjoB4U4=;
        b=Q3tKJNQL6p7K6pKsLOaeLK6mx+v/1Z1R737O6Kq1gNRP51sN/dss47sBRsD0d3Kg8o
         Sz1wn/lzVQTEOp0WVil9M54UQMnsbgzTQ8yiR2hnGfrLgZTnBlx6txvc1sK5/jtkIr9v
         ONzZm0FB4OiQ8wWZNa84MjKBGbHM7KKsH/Svy0NCRSI1XfC4fainYSSZ2JUEMtHxgHG3
         ybNkNyvHbfup27iuoCpyuRBGg/fytMoxWHSVsHCMpfjGUUj11bOy6muC5CPMKGA1y5p7
         1OTe1CZsGOkl/MwZ4j94+D9LagNGgF90WFf2UMH/A6tJngd1sdmbfHBaA02lBVjW+Mk/
         ExNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795748366; x=1796353166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vk8QAimfppOVA6mWM6XoEd6S6tNQdHOsmJkxKjoB4U4=;
        b=YDd8qtrqR63+WkEu6bIOWaStDVHU2UNTBwXEZ6bP0kvt1vO4oNNagNtFRdeJPDXYU7
         113N5BBioBKcPN9bk66kxI6kz76K5UH/h1/SOrw+KDRjpPfCzT+L31DByZ7Omucx2hFq
         3N6BB7Jmu6ghpWUcUizcz+mgNRymBPD9Sj8F8ndghF8KNcYCbexd5v5qthGk6b1tN4Fn
         hTsBYy237FPFcmu9i/5cOQhWdfsm5gWvFarOgphVivF08U6g4YaY9GqaCUjRnnRH0R12
         UEePW2mkZC9KLr7oYEw57dhH5iJyiCbHv5LDTSfwAwkyE7mCp+Voh/6+CJ/PitIHUtKL
         CWSg==
X-Forwarded-Encrypted: i=1; AL+hErE5QsR5EfE5c6a6nYCdA5BIcLZfWOQFspS7uyYN3WeleZel3GHTShIZmo+zyGhPB4KmPoUOvNXg4uxMFBQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9t9bFKyizRYV199/NOJSU7BVDMi1xNZ7AZB7idZujmu8NGZHrG
	VXDO+OWqnUhrZRYqF1VZes5hGRwgsMxSwS5TJcAyOpJSFQMdxhum/E3n
X-Gm-Gg: AZFdTZeiSdOzuAWCyjR4T+3sgmLxlYHiTkGoIu3smZNNHpUEAl3rRJryb4PU780UXns
	K8DUDpXT6uZezmBdDVhfddM81tmq/TMpy0gfvjJuOMPAnA2qAAUDXGMwDhJyhfmknc4ay5LywyZ
	8fRS091HStTnx7dmdWoNNGdmFHuTaHx6Vbg6O1cvHVfkEpRK+eM2M/CEsaxjvirNXMY0uRTwKqz
	0jFNyOTfsFYBjV20jyec1iVRuF/q8PgQn+HhnE77+TAsctAdlzvbctiZnN90CyEckDMWUMFwfPw
	SexgqMGpXNYSNXy+4LlZ8IMEd61VYV3KSe1fh9RcnDLQNi246okHmF84t8PjeB6QNpGTFQydKhm
	Jp3nZ1dZdvhv8uj7o9y4LFDuz5fM6VcRuLixTIPvnmSMwOL0vQWnwzMIlnAvAkQXL8vlsrIW2Cg
	yaGhg/cDTZwxjkRS8zrf8b2MiyKkzKSLwbBbMOpyISN703zd/olk3jtiiltnVbcv/PuBk/rrgu0
	p0UI0p8hGXI3mJRlTB3fqs5NzXK+xBDHR7CH9XaUCKgQHbIQH4b3/KRGdc70wBG9CPtTHR0gqbK
	xdmB1mqdKC0lswMcCErk5vmQG5nAhnlwzbldZqNFwTqJ7hg=
X-Received: by 2002:a05:7300:e9cf:10b0:386:e571:4bb4 with SMTP id 5a478bee46e88-386e5715040mr2828954eec.13.1795748365932;
        Thu, 26 Nov 2026 18:59:25 -0800 (PST)
Received: from debian.prasanth ([103.183.205.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm72013313eec.14.2026.11.26.18.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 18:59:25 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Neal Liu <neal_liu@aspeedtech.com>,
	Tan Siewert <tan.siewert@9elements.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v4 2/2] nvmem: aspeed: Add read-only AST2600 OTP support
Date: Fri, 27 Nov 2026 08:28:17 +0530
Message-ID: <20261127025817.20090-3-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127025817.20090-1-prasanth.padarthi10@gmail.com>
References: <20261127025817.20090-1-prasanth.padarthi10@gmail.com>
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AST2600's secure boot controller provides an 8-KiB OTP data region through
paired-word commands rather than memory-mapped storage. Expose permitted
words through NVMEM for privileged userspace bring-up diagnostics, which
compare raw OTP offsets with reference reads; no named cells are required
by this consumer.

Earlier firmware may leave the OTP macro in programming mode, so Linux
must establish read mode before using it. Programming protection does not
prevent reads, but the configured secure prefix and SEC54 restrict the
readable region. SEC54 can increase until ARM reset, so a probe-time
snapshot alone cannot describe every later read restriction.

SEC00 relocking does not cancel a running command. Since there is no
documented safe retry after a timeout, stop issuing commands rather than
risk overlapping an outstanding operation. Normal reads take less than
1 us; the 100-ms bound is deliberately generous, not a specified maximum.

The read sequence is adapted from ASPEED's downstream driver.

Link: https://github.com/AspeedTech-BMC/linux/blob/769f62b7baa84d6998723b0ea60280e380183553/drivers/soc/aspeed/ast2600-otp.c
Link: https://lore.kernel.org/linux-aspeed/KL1PR0601MB3986A356BD06F98D0FF9AD5E80792@KL1PR0601MB3986.apcprd06.prod.outlook.com/

Co-developed-by: Neal Liu <neal_liu@aspeedtech.com>
Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
Changes since v3:
- Drop linux/mod_devicetable.h as requested by Uwe; platform_device.h
  already provides the required declaration.

v4 validation:
- ARM driver-object compilation with W=1 passed.
- Strict patch checkpatch: zero errors, zero checks, one new-file/
  MAINTAINERS warning. The existing ASPEED matcher covers the driver.

Earlier v3 validation, before this include-only change:
Tested on ASRock Rack B650D4U (AST2600 A3), Linux 7.4-rc1:
- ARM zImage build with W=1 completed.
- Repeated 12-byte reads and cross-pair/final-pair comparisons passed.
- Four concurrent readers completed 40 matching reads.
- Bytes 8172..8183 matched the saved ASPEED-derived reference fingerprint.
The kernel was RAM-booted with the working OpenBMC DTB and initramfs.

Host-model checks passed 4096 protection combinations, 200 copying cases
and 24 timeout cases, including unlock-failure cleanup. Strict source
checkpatch passed. The existing ASPEED MAINTAINERS matcher covers the file.

 drivers/nvmem/Kconfig            |  13 ++
 drivers/nvmem/Makefile           |   1 +
 drivers/nvmem/nvmem-aspeed-otp.c | 298 +++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+)
 create mode 100644 drivers/nvmem/nvmem-aspeed-otp.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d2f5bb2..65f6a88 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -164,6 +164,19 @@ config NVMEM_APPLE_SPMI
 	  This driver can also be built as a module. If so, the module
 	  will be called apple-nvmem-spmi.
 
+config NVMEM_ASPEED_OTP
+	tristate "ASPEED OTP support"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say Y here to enable read-only access to the OTP data region
+	  on ASPEED AST2600 BMCs through the NVMEM interface.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-aspeed-otp.
+
+	  If unsure, say N.
+
 config NVMEM_BCM_OCOTP
 	tristate "Broadcom On-Chip OTP Controller support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 5e70bad..ca62940 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
 nvmem-apple-efuses-y 			:= apple-efuses.o
 obj-$(CONFIG_NVMEM_APPLE_SPMI)		+= apple_nvmem_spmi.o
 apple_nvmem_spmi-y			:= apple-spmi-nvmem.o
+obj-$(CONFIG_NVMEM_ASPEED_OTP)	+= nvmem-aspeed-otp.o
 obj-$(CONFIG_NVMEM_BCM_OCOTP)		+= nvmem-bcm-ocotp.o
 nvmem-bcm-ocotp-y			:= bcm-ocotp.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)		+= nvmem_brcm_nvram.o
diff --git a/drivers/nvmem/nvmem-aspeed-otp.c b/drivers/nvmem/nvmem-aspeed-otp.c
new file mode 100644
index 0000000..cbe05fc
--- /dev/null
+++ b/drivers/nvmem/nvmem-aspeed-otp.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ *
+ * ASPEED AST2600 OTP Controller driver
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/unaligned.h>
+
+#define AST2600_OTP_PROTECT_KEY		0x00
+#define  AST2600_OTP_UNLOCK_KEY		0x349fe38a
+#define AST2600_OTP_CMD			0x04
+#define  AST2600_OTP_CMD_READ		0x23b1e361
+#define  AST2600_OTP_CMD_WRITE_MODE	0x23b1e362
+#define AST2600_OTP_ADDR			0x10
+#define AST2600_OTP_STATUS		0x14
+#define  AST2600_OTP_STATUS_DONE		GENMASK(2, 1)
+#define AST2600_OTP_COMPARE_1		0x20
+#define AST2600_OTP_COMPARE_2		0x24
+#define AST2600_OTP_EXTRA_READ_PROTECT	0x54
+#define  AST2600_OTP_EXTRA_READ_RANGE	GENMASK(5, 0)
+
+/* OTP macro addresses selected through AST2600_OTP_ADDR, not MMIO offsets. */
+#define AST2600_OTP_CONF0_ADDR		0x800
+#define  AST2600_OTP_CONF0_SEC_SIZE	GENMASK(21, 16)
+#define AST2600_OTP_MR			0x1000
+#define AST2600_OTP_MRA			0x3000
+#define AST2600_OTP_MRB			0x5000
+
+/* Normal reads take less than 1 us; allow a generous bounded wait. */
+#define AST2600_OTP_TIMEOUT_US		100000
+#define AST2600_OTP_DATA_WORDS		0x800
+#define AST2600_OTP_SIZE			(AST2600_OTP_DATA_WORDS * sizeof(u32))
+#define AST2600_OTP_SEC_SIZE_UNIT		(32 * sizeof(u32))
+
+struct aspeed_otp {
+	struct device *dev;
+	void __iomem *base;
+	/* Serialize the complete unlock, read and relock sequence. */
+	struct mutex lock;
+	struct nvmem_keepout secure_keepout;
+	bool failed;
+};
+
+static int aspeed_otp_unlock(struct aspeed_otp *priv)
+{
+	writel(AST2600_OTP_UNLOCK_KEY, priv->base + AST2600_OTP_PROTECT_KEY);
+	if (readl(priv->base + AST2600_OTP_PROTECT_KEY) != 1)
+		return -EIO;
+
+	return 0;
+}
+
+static void aspeed_otp_lock(struct aspeed_otp *priv)
+{
+	writel(0, priv->base + AST2600_OTP_PROTECT_KEY);
+}
+
+static int aspeed_otp_wait_complete(struct aspeed_otp *priv)
+{
+	u32 status;
+	int ret;
+
+	/* Wait at least 1 us before the first sample of both idle flags. */
+	ret = read_poll_timeout(readl, status,
+				(status & AST2600_OTP_STATUS_DONE) ==
+				AST2600_OTP_STATUS_DONE,
+				1, AST2600_OTP_TIMEOUT_US, true,
+				priv->base + AST2600_OTP_STATUS);
+	if (ret) {
+		/* Relocking SEC00 does not abort an outstanding command. */
+		priv->failed = true;
+		dev_err(priv->dev,
+			"OTP completion timed out (status=%#x); further reads blocked\n",
+			status);
+	}
+
+	return ret;
+}
+
+static int aspeed_otp_init_read_mode(struct aspeed_otp *priv)
+{
+	static const u32 mode_addresses[] = {
+		AST2600_OTP_MRA, AST2600_OTP_MRB, AST2600_OTP_MR,
+	};
+	int i, ret;
+
+	ret = aspeed_otp_wait_complete(priv);
+	if (ret)
+		return ret;
+
+	/* Earlier firmware may leave the macro in program mode; restore read mode. */
+	for (i = 0; i < ARRAY_SIZE(mode_addresses); i++) {
+		writel(mode_addresses[i], priv->base + AST2600_OTP_ADDR);
+		writel(0, priv->base + AST2600_OTP_COMPARE_1);
+		writel(AST2600_OTP_CMD_WRITE_MODE, priv->base + AST2600_OTP_CMD);
+		ret = aspeed_otp_wait_complete(priv);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int aspeed_otp_read_pair(struct aspeed_otp *priv,
+				unsigned int aligned_word, u32 data[2])
+{
+	int ret;
+
+	/* The hardware reads two words starting at an even word index. */
+	writel(aligned_word, priv->base + AST2600_OTP_ADDR);
+	writel(AST2600_OTP_CMD_READ, priv->base + AST2600_OTP_CMD);
+
+	ret = aspeed_otp_wait_complete(priv);
+	if (ret)
+		return ret;
+
+	data[0] = readl(priv->base + AST2600_OTP_COMPARE_1);
+	data[1] = readl(priv->base + AST2600_OTP_COMPARE_2);
+
+	return 0;
+}
+
+static int aspeed_otp_init_unlocked(struct aspeed_otp *priv)
+{
+	u32 data[2];
+	int ret;
+
+	ret = aspeed_otp_init_read_mode(priv);
+	if (ret)
+		return ret;
+
+	ret = aspeed_otp_read_pair(priv, AST2600_OTP_CONF0_ADDR, data);
+	if (ret)
+		return ret;
+
+	priv->secure_keepout.end =
+		FIELD_GET(AST2600_OTP_CONF0_SEC_SIZE, data[0]) *
+		AST2600_OTP_SEC_SIZE_UNIT;
+
+	return 0;
+}
+
+static int aspeed_otp_init(struct aspeed_otp *priv)
+{
+	int ret;
+
+	/* The provider is not registered yet; there are no concurrent readers. */
+	ret = aspeed_otp_unlock(priv);
+	if (!ret)
+		ret = aspeed_otp_init_unlocked(priv);
+	aspeed_otp_lock(priv);
+
+	return ret;
+}
+
+static int aspeed_otp_read_data(struct aspeed_otp *priv, unsigned int offset,
+				void *val, size_t bytes)
+{
+	unsigned int word_index = offset / sizeof(u32);
+	u8 *buf = val;
+	u32 data[2];
+	int i, ret;
+
+	ret = aspeed_otp_wait_complete(priv);
+	if (ret)
+		return ret;
+
+	while (bytes) {
+		ret = aspeed_otp_read_pair(priv, word_index & ~1U, data);
+		if (ret)
+			return ret;
+
+		for (i = word_index & 1; i < ARRAY_SIZE(data) && bytes; i++) {
+			put_unaligned_le32(data[i], buf);
+			buf += sizeof(u32);
+			bytes -= sizeof(u32);
+			word_index++;
+		}
+	}
+
+	return 0;
+}
+
+static int aspeed_otp_read(void *context, unsigned int offset,
+			   void *val, size_t bytes)
+{
+	struct aspeed_otp *priv = context;
+	unsigned int secure_size;
+	u32 extra_read;
+	int ret;
+
+	if (!bytes)
+		return 0;
+
+	if (offset % sizeof(u32) || bytes % sizeof(u32))
+		return -EINVAL;
+
+	if (offset >= AST2600_OTP_SIZE ||
+	    bytes > AST2600_OTP_SIZE - offset)
+		return -EINVAL;
+
+	guard(mutex)(&priv->lock);
+
+	if (priv->failed)
+		return -EIO;
+
+	/* SEC54[5:0] can only grow until the ARM cores reset. */
+	extra_read = readl(priv->base + AST2600_OTP_EXTRA_READ_PROTECT);
+	secure_size = FIELD_GET(AST2600_OTP_EXTRA_READ_RANGE, extra_read) *
+		      AST2600_OTP_SEC_SIZE_UNIT;
+	secure_size = max(priv->secure_keepout.end, secure_size);
+	if (offset < secure_size)
+		return -EACCES;
+
+	ret = aspeed_otp_unlock(priv);
+	if (!ret)
+		ret = aspeed_otp_read_data(priv, offset, val, bytes);
+	aspeed_otp_lock(priv);
+	/* Complete the lock write before handing the mutex to another reader. */
+	readl(priv->base + AST2600_OTP_PROTECT_KEY);
+
+	return ret;
+}
+
+static int aspeed_otp_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = {
+		.name = "aspeed-otp",
+		.id = NVMEM_DEVID_AUTO,
+		.owner = THIS_MODULE,
+		.type = NVMEM_TYPE_OTP,
+		.read_only = true,
+		.root_only = true,
+		.word_size = sizeof(u32),
+		.stride = sizeof(u32),
+		.size = AST2600_OTP_SIZE,
+		.reg_read = aspeed_otp_read,
+	};
+	struct aspeed_otp *priv;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return ret;
+
+	ret = aspeed_otp_init(priv);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to initialize OTP read mode and secure prefix\n");
+
+	config.dev = dev;
+	config.priv = priv;
+	if (priv->secure_keepout.end) {
+		config.keepout = &priv->secure_keepout;
+		config.nkeepout = 1;
+	}
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static const struct of_device_id aspeed_otp_of_match[] = {
+	{ .compatible = "aspeed,ast2600-sbc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aspeed_otp_of_match);
+
+static struct platform_driver aspeed_otp_driver = {
+	.probe = aspeed_otp_probe,
+	.driver = {
+		.name = "aspeed-otp",
+		.of_match_table = aspeed_otp_of_match,
+	},
+};
+module_platform_driver(aspeed_otp_driver);
+
+MODULE_AUTHOR("Neal Liu <neal_liu@aspeedtech.com>");
+MODULE_AUTHOR("Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>");
+MODULE_DESCRIPTION("ASPEED AST2600 read-only OTP NVMEM driver");
+MODULE_LICENSE("GPL");
-- 
2.47.3


