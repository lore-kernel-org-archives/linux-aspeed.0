Return-Path: <linux-aspeed+bounces-3647-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98CC106ACF4
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Mar 2026 23:08:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fX3C21tf2z3cP3;
	Fri, 13 Mar 2026 10:06:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773327961;
	cv=none; b=kbKmC+9pOR6ctLJ2M/hFuF0V3/NLqeF8OLsJbuyM0SYqGUIc6d9+3aAODolhaabJ6uPTnohY4IcHjL9+5emglVoex1uVe7DDCuPCRfSfqKbll8CdCk+yozZpLdnfwFLDXBVWssHkr2XhgbznV50GSm+t6Ieo7UMOsHajnwggwGCsnXlPfsV2nRJ9cD/aOFmVV8pkFkZuKDDlmkhDWBUhKIG69QyzXdovTXx5kwaWgcgWnRGPso/9NH6lziXzF+1bI90UpACmDd626d/937slRS2xIsgva1+jv4LsVaTB6aPfCaHpUcY2mHttbuIMtVQfZIDh6QA3CNjbeZ589SbS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773327961; c=relaxed/relaxed;
	bh=I/dvLEb0C2jsyffhRQXnxhbz012D3R783nTzwCwYAxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKCHwERC0cDYYFx+4GXeB4588826VED6IASh7dPUNIdLmAcUJkD5/k66947hxTFjXBa/EXqviwcpYSwLQ73Skf8qhwvD7zgGr0N0b0+yzNKJs1/jlpU0C37rXJF9zRDb9MkuXLZlSMfXk8lANTyhBfy1yji9GwVcR9du/Ozmk+rVLD5qiLwJ616aWNoVI/Teu4RgjWepDo6P1gGOrfl/Xyfu4EcldgQQC4CKboAb/6voLIySkhl08qnFW672k0ajvIWRZpvaZH/ubRC4KgijApzZjbstsZGfIYml1M1Pv3MQ5vQKz54bQjnYQzLN4m0TnRiuMOvQIEyevkBWNwLV1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.a=rsa-sha256 header.s=google header.b=fWcg7SBf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com; envelope-from=vineeth@bitbyteword.org; receiver=lists.ozlabs.org) smtp.mailfrom=bitbyteword.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.a=rsa-sha256 header.s=google header.b=fWcg7SBf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bitbyteword.org (client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com; envelope-from=vineeth@bitbyteword.org; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWrXm2xxgz3btw
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Mar 2026 02:06:00 +1100 (AEDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-7d1872504cbso1320396a34.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Mar 2026 08:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327958; x=1773932758; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/dvLEb0C2jsyffhRQXnxhbz012D3R783nTzwCwYAxU=;
        b=fWcg7SBfRtyIE/8yit2IM2feuS0R/RAsY045KGr7/EOmAKcQLgmbta8ocxKn52JWs/
         mNBvk6rSvSlbPVxakqGTGGRwj2rXn9trSRNyDjgh7316xuYn/9XJGD41vvFp7nkS57so
         MFHTqIXQpirEqvHdXX+MhjBjOEJgIWcW8GI5fUW9h/3cDBwZ9ttB+u6BxDM3eVKdPCTE
         SyQjxaU0W36lHQs17BhV4uwpMX4t8eLE7CotzozqqtGkXwCTd9Q2p/flr/z42PUXspsP
         ae9HBSmUSmV+7lgRMZa2xGp4yISIRfL5qoy/xd+MlFvoKJ1V5fMgxWPAL9XMIES+spII
         Tywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327958; x=1773932758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/dvLEb0C2jsyffhRQXnxhbz012D3R783nTzwCwYAxU=;
        b=IlCg1YLgWbHNgLTiDmBd96uznSvndgeSLf/iugfCuovMHKf06lMcsMr4fUGvJ72T1B
         Z8cPmQ2IFrQJuSZ5ccIZce46JGTLxgU1Yzw46c7woPzNl3mLK1ZUL4RkxRqZQu9ec2Ek
         MVWy4F4WNmmuI+WwoS24auOBwdbVSfDA9zGWAp+xdt3jG8JYtPdvVtjmP8egXf58Olvj
         fy9KCnU/qk8XtIAB97sX1FVywBrl3dOEFsG8bCtvoPxokoL5v6pjwUGCJtli5IO98YX6
         VcQJI4XXkqd5uxEQi5Iy/PMeRrfqW5CuI91HzJbBj0kHiCEsNVPuvylzkVAY7SkkPvKk
         nJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX/gFdS2ZRHJIWaoS6s25HB/eZBGxiLb32m8VvqxRf87qxZR7LQqL74OPCrEZYtWHl3oEQTZkC6bnlAG4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyheIgUZgCCm55uEuz5G/q1uVgrYCRGhn+RAebjrsQ+U1CMrbaS
	fNX6erCeQagErsn4v7p7Zvc1CLrSa/xrAoWYM1rdHZADJwXDHPDs7JAICP+ozPBiF+WEVZpXxyo
	6LvpO3IBGiA==
X-Gm-Gg: ATEYQzxpD4K5KpT5LNDoj7JdKPP3MtbqkCNwscsOs/B/88EcsfXsBnGUz3ij9/COMjH
	naWNsJXhNnHLLKOqVsd955yO2QB3998hgGmZvc/3I286gCs/kOAWYigl4QfWXZhiCGtx86RsKh+
	vFdY2XyCOhRzLYfxlizIOwpgzDSALXAz24+6oSftud23mg0RrwazChVm8Nvd6dvMTcnEKKb2XUU
	KtcBFP8m7XuRV7C4+/SdGZ/Vcio0+DsIf5p1pwlmdBFAj7JQNW/YiWszJU+F6l4+lyIMPhPY9pZ
	miU+iuPe9tegGTY9lDqJzXqA7j+H2q8RWkyF9dTQK5kxPG0qKr6cgJkMAlcBRpvPpshKFxNZbre
	tH8OpTKDN4JvmM6AGP/IP7QVfvnMbOxqv73Q1IHWV6BW6zJl/YpDlvzaqqoIJ8L1ifiryYUH/g9
	JQj7/urWeFcT2z0sKf0gF9dNyg4aXbNF184/ka93ZoBhtIvJGbrHE0I5S3u8Xv+0pt+MNX7obiN
	P+V
X-Received: by 2002:a05:6830:7308:b0:7d5:96e7:bed with SMTP id 46e09a7af769-7d781c0977fmr32729a34.2.1773327958628;
        Thu, 12 Mar 2026 08:05:58 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:58 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-fsi@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 09/15] fsi: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:04 -0400
Message-ID: <20260312150523.2054552-10-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
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
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/fsi/fsi-master-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff338..07b88ef49cc47 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -229,7 +229,7 @@ static int check_errors(struct fsi_master_aspeed *aspeed, int err)
 		opb_readl(aspeed, ctrl_base + FSI_MSTAP0, &mstap0);
 		opb_readl(aspeed, ctrl_base + FSI_MESRB0, &mesrb0);
 
-		trace_fsi_master_aspeed_opb_error(
+		trace_invoke_fsi_master_aspeed_opb_error(
 				be32_to_cpu(mresp0),
 				be32_to_cpu(mstap0),
 				be32_to_cpu(mesrb0));
-- 
2.53.0


