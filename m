Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F96606A31E
	for <linux-aspeed@archiver.kernel.org>; Fri, 27 Nov 2026 02:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vZlnvysj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbJ6C6NVfz2xqh;
	Fri, 27 Nov 2026 13:59:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795748355;
	cv=none; b=AQxIG5Ews6BSQiMscw3at9s1I3m86NWDDjEbR8BXh1wHV0Guy6p5y/qOQTZPMgIBYwJsWEGD87SiR9c2wB+66hLz/TS8rb7MnTf+BgiIQML41mprBTAgr1Ex2Q0slcwJ9GHVLU/WSR5APVMM0MXR51Cfs5osTOykiraDRSggyQYdA8MgqgH9XD3t2ZASedsbcmL5O0D22r2tbx7uvk2GqHQyMkTf9fXqNmDSo3SPoFr38J6P8/vW6zm/z8PeORqI3jQpJpg+fLxOaPV4Vmh4Xk7iwk+vCtrB6m3YwL1/qKyDsO01z1gN4EbpSUkcn7NgXagcSz0w0rv8KiiKyiMnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795748355; c=relaxed/relaxed;
	bh=btx3limhEerqDxGaD4XQgQujXJCSxle1lIB9AKeLA2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgWvafTwzMIyxq3uAY94c/rpUNpv7aLyiP/UdfCkdFyFD+vGAmiUJ4boasZ8yxAIcBuNPeYmzxwL5HOizLsnzx7ti/8/UJUQMAbIHmvamcxNXUlSmeTUYT3MQwRrTZiFjOwPffyshDy6zn8vx+L9eaPOT9mR1gfxrNtxfvWHQS/U3YcNj7uf8wDeKHJ+z4Iz3uCw2naU+3mlUthhn8GbwsoS2ANEPsggdfdphgnH6fl0ipDdseMcMtYFbBMPX/vTEEgcZM7WyMUgpkAsqlcQGG0jI8YIzJCpWiHQHxGbxIuzGQT4N0coNIL5jhFEGz1EnxiRU/j2QMq6dDgcE+lGTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vZlnvysj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vZlnvysj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbJ6B0WMYz2xLs
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Nov 2026 13:59:13 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-33fb4680717so3841720eec.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Nov 2026 18:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795748351; x=1796353151; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=btx3limhEerqDxGaD4XQgQujXJCSxle1lIB9AKeLA2k=;
        b=vZlnvysj5wGlJmnw1D6zJtR+RoyfiFA2+7yxuZmOZag9ykF2WcicvTL7UAJ36OpSa4
         SwDqlQZcBt5LnGxCksBK4Nwqy6rBQyjUz9jlZ6RCjoBRxNrbnxvnZuTrlWkICBPLKWw8
         8F5h+BoWHL2IcRNAbbasuKl1Huo5n9vcooVyFeaunn1HW5AETVJX1J/YAJyTPWJ3OiNq
         L+SmsS717pOQxMdChS6i+ThDQHKWqXfJeee7lbApLt9ae7806sCzAiojRknB9Wek133R
         aYsfMcPZqP3N47ljzAtx0k/jkly7gB/GgKDGDVPyLB0n1+eXuuOENIfZt9mgQHCm23w/
         GevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795748351; x=1796353151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=btx3limhEerqDxGaD4XQgQujXJCSxle1lIB9AKeLA2k=;
        b=JASnEdfvQrGo4dbKDWsOSebNXK9yCvfiqsqPLrw/4HeiG9osUlH5qh8MLnRjnDyjqn
         uZPcuDC4SCi/W7oGRQKWqt5zZiaBQjAT5fz6FjNGDO9vk/XERcxyf/HgG6ulvcVMf4XT
         qiT7q+UzXrooflwQl6kMU3eW3ToYO23XXZnXucas+Mo4YIZw5V6xK3Rcge0m68qCxnvr
         qJpWQ/Ubx5eCix0VqD3uoLiRtdadNerIOtoGnsiDdtb6TBmTuHUxX8xB0w41PNzUWPqU
         4eqp+PF/ranDKCY1nreVp1MX9ItlT9ywl/dyasnl7TnK8JJopeqYS6g8KmWxX5vwCtqu
         olcA==
X-Forwarded-Encrypted: i=1; AL+hErGvWDjhfOvQo7vlHGaKeW73VX0ADDb7AU9Zh14+5t9t/n8c9BVDu591NBxOGtVa6hQWsGvSeWnhYpJXbSM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+d06b3C1L9PD1PntZrW4ObuIocI1W3CIUTuAOQUqDI+tE2rsQb
	cfAX/8KYzeD3BICC9ku6pNJiWB+s2cSbYJjO86/pzEUzRAaIHV+xDyMU
X-Gm-Gg: AZFdTZcRqaLU5Ykqi2xDEAP835PvjelummKRtR7Mw6JwTqkVTGSgLF/74Al01Ie9s2v
	UBx1a0zdlxgLm5Z8zkzPBeYQtkFN0khgIkxCB2T7yDPT4671L1B/LsQUUYaEfM+AXFUkiQpdKcH
	yNVsdIFLP42tZpBPP3t5gUTjrI10LzGcobDJ1XTOsR4/waEjLFSFmQSJh8GtqoBq+mzgWliHQzy
	Zx5eCdO1Q3zwTK6wHKKEFxWaaYua24rquFHZQjMkElj+Obz5KokQ3KeZn/Ggd8Cy+OK9V5N84KC
	PXMPOljmv9YXyqsRP8GNBEs9Qi/Pzn1/YDnwCQjTSyaVc6RBmj/SBtJp/4HVn9mGK//dKfK/EPZ
	SFEUBxaW+1zj62gmC5u8UWgipM5wHnljdKfs6ULM5dKw4Th75EtVy66GSF18dt3tmkZylMyTVfw
	tDhtpjwVndb8LscFQ65QH940r5/3VHzZ3ZbRUchs9FTuLrBXX8oimXqLVh1iyTsfcGsSkHeg4ZZ
	gTqIfkvO8p17adM1j+fEumitawdZAqhdhs+UKvxgaitNmQZXxkoHogemK4pi4voUYK/gphL/ddW
	EbhKKJu/a6c+zqaxAHiHOhwRGetxLllJ2jTSMrG+ZyWGFjg=
X-Received: by 2002:a05:693c:41d2:20b0:386:ebc5:4747 with SMTP id 5a478bee46e88-386ebc547e4mr1066918eec.11.1795748351083;
        Thu, 26 Nov 2026 18:59:11 -0800 (PST)
Received: from debian.prasanth ([103.183.205.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm72013313eec.14.2026.11.26.18.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 18:59:10 -0800 (PST)
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
Subject: [PATCH v4 0/2] nvmem: aspeed: Add read-only AST2600 OTP support
Date: Fri, 27 Nov 2026 08:28:15 +0530
Message-ID: <20261127025817.20090-1-prasanth.padarthi10@gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Expose permitted AST2600 OTP data through root-only, read-only NVMEM
for BMC bring-up diagnostics comparing raw offsets with reference reads.
The series also describes the SBC's NVMEM-provider role in its binding.

Changes since v3:
- Drop linux/mod_devicetable.h as requested by Uwe Kleine-Koenig;
  linux/platform_device.h already provides the required declaration.
- The binding patch is unchanged.

The previous v3 series passed ARM W=1 and B650D4U/A3 read validation on
upstream-based 7.4-rc1: repeated reads, pair boundaries, 40 concurrent
reads and comparison of a 12-byte range with a vendor-derived reference.
These hardware results are from v3, before the include-only change.

For v4, ARM W=1 driver-object compilation passed. Strict checkpatch
reported zero errors, warnings or checks for the binding patch, and zero
errors/checks with one new-file/MAINTAINERS warning for the driver patch.
The existing ASPEED MAINTAINERS matcher covers the driver.

Previous revision and review:
https://lore.kernel.org/all/20261121034053.39878-1-prasanth.padarthi10@gmail.com/

ASPEED hardware clarification:
https://lore.kernel.org/linux-aspeed/KL1PR0601MB3986A356BD06F98D0FF9AD5E80792@KL1PR0601MB3986.apcprd06.prod.outlook.com/

AI assistance was used for driver revisions, validation tooling and patch
text. Hardware tests were run by the submitter.

Prasanth Kumar Padarthi (2):
  dt-bindings: arm: aspeed: sbc: Describe OTP NVMEM provider
  nvmem: aspeed: Add read-only AST2600 OTP support

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

