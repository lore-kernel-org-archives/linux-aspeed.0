Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C0606A6B8
	for <linux-aspeed@archiver.kernel.org>; Sat, 21 Nov 2026 03:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HshYOSXw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWdKr0fmzz2xXB;
	Sat, 21 Nov 2026 14:41:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795232495;
	cv=none; b=JLQLlDDzIprZ56zQE6bYLIZxILkpW1VivA7zJTSAIUFl/moCDgcnYG2XCbthxzBkUFL86CAYnW7TWoXIKuTQg+tSwf/jcB2l+EjCD/0E6d23w3maOKufs/v8ro0RGzn7Cym9Dox+izSKqmRrJfbTZxxWhAfHM+JNdQU1uVP0fwr4252cjPrvR4gLer4YKuO3gOClrQrwQNQFIPVCHemfNLFHMhMX8hyfEdwjj9EtmRvxAMWxMvwykE2ZmO3cy40VzhkbCfiMk560rI09zWc1+Xr6wXyIoEq1H4KqlWmJGj/ILuL2Q4AF9nisaySFja3QifStwfFZnOes0yCtCdzuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795232495; c=relaxed/relaxed;
	bh=asqkoYbz82hEaVuDlqAKtg9A95Bx0CAB6i8FMp3RVm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Irod9ZGGPo7mx490Ee/Jd2STx4K3nkJcKA+9j2FE1t/C32M+Bbp+O0Q+k/02OByzGRjeXIy7SVOVuPCeaXd/xWPBTBQWVSDBU7yxlqpWjeALYwSfGDWcNouYP0cwIrA6kvYBAmqz4ubeSqGL8lZYvTh4mVQwEF+JsW4U7Z3gCXwzCSa1XPFU4hcWsak2W/XJJQmZmo+5Q6WB6Z7C78r1QqyWOa3bQywoy22fh3JhvGJecYY65yg9eCcJfPAFtcG7GO9K8ITZKF0Cyy92lBjw4i+CQKqj5T8ac3Xw0XcHzdTwxWq7QQofQawkh36DeBvpZ7wli0sfQlYorlFFQsyA+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HshYOSXw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HshYOSXw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWdKp3nbxz2xLt
	for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Nov 2026 14:41:33 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-382f4710a17so2585553eec.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 19:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795232491; x=1795837291; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=asqkoYbz82hEaVuDlqAKtg9A95Bx0CAB6i8FMp3RVm4=;
        b=HshYOSXwk6HlOm7TuYfU+QHq6aL5XxfPJ+JmY5ECgZsIue0H6AyPp+rXYCWXxyXw+M
         t2QVBlpKHK0BVNTscyRULKd9+/qVD8vnRRTnnY6r07cZth9dfIs6IYZQSr1H8I9Ax5cp
         eS0fqisn4b97hiO3Tb129R+NZRX4RvXfDoW26Vw92PTUpfv/NKwsB5HZgprWn5ba8Qjg
         GVQb0My883pmqe1Fg+tZMH42vVN29261bT9q2t5V29qJVfe41HU10xrUBnChd127/IV6
         32TJF93LX0kmFYIINWAbc5i0INcUNbU+nilq31ZHKhrxQdZ4jyrXyg2n0W4MF7Zc04Su
         CSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795232491; x=1795837291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=asqkoYbz82hEaVuDlqAKtg9A95Bx0CAB6i8FMp3RVm4=;
        b=yhXxD2FLvxuzxU069DQ/gPT0C3pYSiHuDZk/8xqPz4B7lp7L8TT0MtlPOKXftNiRdV
         rCwHswLYJ+2DrG8LQk3G2aTGdQ0UmPaMPNsu+AwU/1gVl5ESpMRpiWUbC8LAgRSUV1rq
         53tLzJVKv3yJSpgVTqbOvIuFi1+cDmCZ5SdO35352O+o8zc/nfHZx8zsPdmTOMglmeVw
         f0PIcbVK+LgcQwdYv5Jd1+FnxqmDhFkUxhClpp1e7iYIsxpOGUBEfI+urF4DwWbL81Up
         dMr5aNNM/AW5Nfa5Ud70CYX+MsVvzOy7jhl7DpRQoeTenKyug17IfXFWfeZpwN74vpts
         0lew==
X-Forwarded-Encrypted: i=1; AL+hErG31fNjwjpWeRcSXdkpw5uGpi7yt0ZWrtSXgfGNw9j/hcKK0kE53vzh0MDl0vAMP6aDB/dVYavrKdk3Jdo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z896K7ZB7NaDWAL9QqYvZVzRTjK1x1f/4KU0bB4Zfz0pVij6GVZ
	cpwmQc9vsBhA6ykysOUm4Vf3m/gn1WoUSALh46IEWB7AFuO1M+z7S1Zq
X-Gm-Gg: AZFdTZcus+E1/ba5lMYVS25e9scKxUSbiEmFr8UeJ7dF316xrtq/Bi0gC1vQQfCsVA6
	Vab4xpr0VadmY5ZpOElrMCHI2plaFJAC3HzHvAdj5RyhuV5EFsKFUinW0+dsphfVkNU7BKeRi/k
	mKMK5c1bZhooWkjkBiniiFq8iOOr4vTa4WGQ0XfgMflbeD0bZ0xORfAd36r/LqBbTxdXvd8T5fr
	22CMrC9P48jTSpr1gj4F0kIXrnpFj7Cy+gZGFadHAcrJum9Z2VoZXblAGDzooAZEz+7XlJXk9L3
	oBW97b2TsNyTlnmN/N5aqke/tnPjiAFGVi6Nt3sc5tOYTjsgfFbVN2UKVXMr6KVyF8x8eQ8i+24
	rKo9A6lXSdutJ7qvjH/5xOTUlP4skTOmmEo1f0pwK+jWZrxhkPqinD1X0RDvZY52RgTXryZTa5z
	dsFsX6GG06IM7kTuyKPEoHyfOdGVvd0ZuHevlkBK2T4GYx0WNQdSN5mWntk1SvHJWvbPjaCIGuN
	XyXleCpyGSEcsnv/fNQY9qMabClb+D+9nk5rQzwi7y31QuXrLuN3dDpSpeCEH6BaqT2jVTYiLIZ
	qAEudN8t5U9xNX+Jj8mLPywk4W0LA20h1gSHR6w8K8p8aA==
X-Received: by 2002:a05:7300:ce8f:b0:375:7be3:1bbd with SMTP id 5a478bee46e88-38570b336f4mr4071171eec.23.1795232491106;
        Fri, 20 Nov 2026 19:41:31 -0800 (PST)
Received: from debian.prasanth ([103.177.82.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm20891464eec.3.2026.11.20.19.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 19:41:30 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: srini@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	neal_liu@aspeedtech.com,
	tan.siewert@9elements.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v3 0/2] nvmem: aspeed: Add read-only AST2600 OTP support
Date: Sat, 21 Nov 2026 09:10:51 +0530
Message-ID: <20261121034053.39878-1-prasanth.padarthi10@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Add an NVMEM binding and read-only access to permitted AST2600 OTP words
for userspace BMC bring-up diagnostics.

AST2600 accesses OTP through shared command and result registers, so reads
must be serialized. Earlier firmware may leave the macro in programming
mode, requiring read-mode initialization. The protected prefix can grow
during operation, requiring live protection checks. A timeout leaves
command completion uncertain, so further commands are blocked because no
safe retry sequence is documented.

Supplementary design notes:
https://github.com/prasanthp20/asrock-b650d4u-bmc-support/blob/main/docs/security/ast2600-otp-nvmem-design.md

Changes since v2:
- Explain hardware constraints; put test results below the commit separator.
- Use generic ASPEED naming and named mode-register addresses.
- Share unlock/relock helpers without mixing scoped locking and goto.
- Return EIO for unlock failure; simplify pair copying and registration.
- Drop redundant MAINTAINERS matching, zero assignments and probe readback.

Changes since v1 (introduced in v2):
- Add the separate SBC/NVMEM binding patch; rename the source and module.
- Replace double polling with one bounded poll after an initial 1-us delay.
- Initialize read mode and read CONF0 once at probe; use a fixed keepout.
- Check the live SEC54 range on each hardware read in confirmed 128-byte units.
- Simplify word copying with unaligned-safe LE stores; accept empty reads.
- Adopt scoped mutex locking and managed initialization; simplify Kconfig.

Tested on B650D4U (AST2600 A3) with upstream-based Linux 7.4-rc1:
repeated reads, cross-pair/final-pair comparisons, 40 concurrent reads and
a 12-byte ASPEED-derived reference comparison passed. The RAM boot used
the working OpenBMC DTB and initramfs. The ARM kernel build used W=1.

The selected dt_binding_check target passed using dtschema 2026.4 with a
local diagnostic-crash fix; no checks were disabled. Two unrelated TI
type diagnostics remain, with no SBC errors. Host-model range, copying
and timeout checks also passed.

AI assistance was used for driver revisions, validation tooling and patch
text, based on the downstream driver, review comments and Neal's guidance.
Hardware tests were run by the submitter.

Previous revision (v2 cover letter):
https://lore.kernel.org/all/20261120174440.123487-1-prasanth.padarthi10@gmail.com/

Patch and review history:
v1 1/1 - original OTP driver and review:
https://patchwork.ozlabs.org/project/linux-aspeed/patch/20261113034213.158390-2-prasanth.padarthi10@gmail.com/
v2 1/2 - SBC/NVMEM binding:
https://patchwork.ozlabs.org/project/linux-aspeed/patch/20261120174440.123487-2-prasanth.padarthi10@gmail.com/
v2 2/2 - revised OTP driver and review:
https://patchwork.ozlabs.org/project/linux-aspeed/patch/20261120174440.123487-3-prasanth.padarthi10@gmail.com/

ASPEED hardware clarification - Neal Liu:
https://lore.kernel.org/linux-aspeed/KL1PR0601MB3986A356BD06F98D0FF9AD5E80792@KL1PR0601MB3986.apcprd06.prod.outlook.com/

Prasanth Kumar Padarthi (2):
  dt-bindings: arm: aspeed: sbc: Describe OTP NVMEM provider
  nvmem: aspeed: Add read-only AST2600 OTP support

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

