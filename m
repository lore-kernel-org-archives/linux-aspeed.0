Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D5606A31B
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJDrSsWT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLNQp145tz2xH7;
	Fri, 06 Nov 2026 13:28:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793932130;
	cv=none; b=NRvL7Hd0I7vU3HsWipaHgegvNfK971t+C5CJfCZQWZk64V6MMDspuOgJg48ykNxWXXshyKFGGmEogZUNZFNW02WRmM+HOT4b7yMBbRY8eWq5XMTbbkGMIEUgXbiErAMrQcYypc4ObPd+Llj6l8EXn939HuGpG3wdcg6SB3Ha4MMI2AkXF2XknHtggIUPwUcpeA/jZ2CHIq/kgTh8ytGgck4V5Gq9l0EQCrHawIr1mn4/DAoiwEWXPgrRvb/dtplwGG3XqQy0Y3bLNUI2LR6JKfc3gRTj6bAbUXLIrBgXgKv3pdhyiu4zyF3bI9k84eelDkIPWkaw4zguvHzcsFY/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793932130; c=relaxed/relaxed;
	bh=mVFhMdPaOpZaZhoFk4x/27qwSHFs/IDKrnB1S7WQ5Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry0kFrPkY1g2keHosh5In+BupQAlEeQzoyMHN8Zz7XHnrInpllVLf7d3os5DsvMip3T1YM7zIFjhlomIKivfnD2dbGNQzyTo1PLzuKPhWCGkYQD8aAnX3ycrAaeU2/6kvBeMO7k5D+/5M6U/DRq6EdaXO/idQk+ci9R0sRq4reHeL/l9vMUrf3gz+sZ6C+TreE49b0vdeKp0JlPmWMePTRCpU53bP6xR07EzGyuhlfjNbYLiu6RwASyweKUFMCQZk22AGqNCaWy7N3l5uSPTp/vAdlD5BkQ9HD6z9AOX4dkzC7642tjmqaxaZ5LRMfFMm/8hNDTFsXk8+73J2OcJnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJDrSsWT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJDrSsWT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLNQm4jDNz2xGr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 13:28:47 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so279849eec.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 18:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793932125; x=1794536925; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mVFhMdPaOpZaZhoFk4x/27qwSHFs/IDKrnB1S7WQ5Wo=;
        b=BJDrSsWT8oz5u3miPeJ5AnaRGdPorhMyIlcSH7whST2XjM1FxL3veuMCydoRgiMnkO
         s43zyPR4Crld4GGhzo9VmijCbzKOV3Uv//1aMtveEq1cItvACjQUWCjlXaa3O9C1RfQO
         GvBFHPplJPxT9hIsqKho6sLOQI0LtjhYcMeIjy9gsxVYDuO3sQzgDP7kM/gX04irlEed
         ExQZk9twuN+OzN7XvmTvOTI+hr2arjK1cz2xuavASGXcRPp4+EVe8G7neJ7g9amj3Hqo
         VkihVMUt+qcj6aehhuWOgiwaZswlRxMsY4fCNEnnta7sWvXXCt0EsB2M7+i9N7Uk1r/R
         xEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793932125; x=1794536925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mVFhMdPaOpZaZhoFk4x/27qwSHFs/IDKrnB1S7WQ5Wo=;
        b=kjrAD7Dga6NCaDikUSHdismEHJnW9B9Lr4RJsOOjN7d4cbxTGVTYYTnSbhS6YAgy9A
         dptF6OGXdZ6/Yu/rAdtVBoR2vUio1w+/O2cvCRCatskrIisTKw4Hlr6U/Dlol1HAvVL3
         2as+mYByBHiwBWo9CSPU0HHW+9+xAspkII0O3Ixwl5GaCQ8O9S34vd/RVCNqqA3ymTmZ
         C/TlRurMMWmfXZxU2v76KVw7m3rJKdsCnmiJbuKHqe5cU5gNLzxnhiYiQLiAqCtsykwf
         2iQSaGs06q3x219+JKEst+Ck6VmxMp9s+CU8SE2j63pvSArDeCRuk2JWNWldD0mD2LkE
         YWwg==
X-Forwarded-Encrypted: i=1; AKwUvBwH+p5DycKY1FbgwJaaibVtLwJ3r+yLhUxlutt/iJ2rbhprqA4J+6QNrmZ39ifnfAV3vRyDGfaN7YNyZzw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+XW3qM3MdPOWoyokHBMFnT5kBINI5j3vrEIOeAqZ7/eKx6fDPu
	fF50bPYR1IOtXSO8VaLxzft9kaCuH5FOdujpbKKbW2DEmkUk6iNOPY9J
X-Gm-Gg: AYBFou0IaCZgBC4ndf8URJXk0iDP1VW+UuTH4EgalBP7Uh9Ijy2Owv1OKXjbegKRDya
	sY7ykHRZFAEbhPBUi4+w1uq1LnvCNRHUIgtyTNy5L+qNoitNJG+NS4Qxkkl/iuM7OJ/4vF39tbA
	nD9HiLhouNPsSnsYme4FC/qZCQGN6hEi65JxryRUQaLS5fcO6+qL4OgaO25A56+3+q0o7xXyPWL
	bqKVkGO9a6j8NzzB365gB4SpN4YeLFrZbWqo8w1SxSkWoBnzSfp5TBxvVhERb3Xx7WvulUEz1ld
	F9++rIJUSZQdUdhV+zIzFjU12oHIU9ohxiCU7lSEJ+A6evNffIU459qri5ch73EOqawiFmzLfD0
	cZqfJT0YG3a3rsKn++92uHBDnK/VcYdx0hZtlivGX7LXBJhpgonoOU2+9G62z2y2JIJuqmJdha1
	h4bxdyJAROyxYzPN5SKS414dctwcWYZYvapNUhmZ7tXgY+i1xoXQ9bN1MgAMmCMp9Y3ZGhiDA/r
	XOSmh2/MP18tB6lcLziD0stEksMWceuS6nBZhohbP1yj/g8zg7tCLlceAXelr5/6NvOtXdAxTJ1
	XW8/qqLyad/06XAvecrex007WzQLTkjVc5k556gXtBNI+w==
X-Received: by 2002:a05:7301:929:b0:369:ef63:ea95 with SMTP id 5a478bee46e88-36f76814c3bmr1285854eec.6.1793932124917;
        Thu, 05 Nov 2026 18:28:44 -0800 (PST)
Received: from debian.prasanth ([103.183.205.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a47esm1697186eec.6.2026.11.05.18.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 18:28:44 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: linusw@kernel.org
Cc: andrew@codeconstruct.com.au,
	joel@jms.id.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	brgl@kernel.org,
	tan.siewert@9elements.com,
	linux-aspeed@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v4 0/2] Aspeed GPIOP handover with managed controller lifetime
Date: Fri,  6 Nov 2026 07:58:33 +0530
Message-ID: <20261106022835.10709-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105152348.8567-1-prasanth.padarthi10@gmail.com>
References: <20261105152348.8567-1-prasanth.padarthi10@gmail.com>
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

This series continues the AST2600 global-to-local GPIOP passthrough
handover work, rebased on v7.4-rc1. It adds a shared pinctrl lifetime
fix before the G6 handover change.

The registration lifetime issue was identified by automated review:
the G6 callback data is devm-allocated, while the shared helper used
unmanaged pinctrl registration. Patch 1 switches registration to
devm_pinctrl_register(), ensuring unregister runs before earlier
devres allocations are freed. Patch 2 retains the v3 handover logic.

Changes since v3:
- Add managed registration as a separate prerequisite patch.
- Keep the handover implementation unchanged.
- Add KASAN lifecycle testing in QEMU and on B650D4U hardware.
- Update validation statements to distinguish lifecycle and power tests.

Validation:
- Shared helper and G4/G5/G6 objects compile-tested with W=1 on ARM.
- G7 SOC0 object compile-tested using ARM COMPILE_TEST; this was not
  an ARM64 build or G7 runtime test.
- Generic KASAN boot and one unbind/rebind cycle passed in AST2600
  QEMU and on physical B650D4U hardware. Controller entries disappeared
  on unbind and returned on rebind; a subsequent debugfs pins read
  succeeded. No KASAN reports were observed in the captured tests.
- The final v4 source tree matches the tested v3 tree plus the
  managed-registration change; only commit order and messages differ.
- Earlier remote power-on/off and physical-button power-on testing
  used an OpenBMC 6.18.24-based kernel, not this v7.4-rc1 test kernel.

The unfixed runtime comparison has not been performed. Concurrent
readers, probe-failure injection, mixed-pair forwarding, protected
writes and SCU510[28] hardware handling remain unvalidated. Existing
questions about probe-time normalization policy and concurrent SCU
writers also remain open. Electrical measurements are outside the
scope of this lifecycle test.

Supplementary procedure, exact source/config and logs:
https://github.com/prasanthp20/asrock-b650d4u-bmc-support/tree/64eaccfde9ac4ec35646c0b7a8663486775b5d3b/docs/experiments/03-pinctrl-lifecycle-kasan

Previous version:
https://lore.kernel.org/r/20261105152348.8567-1-prasanth.padarthi10@gmail.com

Please review the shared lifetime fix and the GPIOP handover policy.


Prasanth Kumar Padarthi (2):
  pinctrl: aspeed: Use managed pinctrl registration
  pinctrl: aspeed: Hand over global GPIOP passthrough to local mux
    controls

 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 145 ++++++++++++++++++++-
 drivers/pinctrl/aspeed/pinctrl-aspeed.c    |   3 +-
 2 files changed, 143 insertions(+), 5 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3


