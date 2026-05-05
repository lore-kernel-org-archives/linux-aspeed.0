Return-Path: <linux-aspeed+bounces-3998-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238EDFF8855
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 May 2026 00:03:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Fw646Cfz2xjd;
	Wed, 06 May 2026 10:03:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777976850;
	cv=none; b=Sq6UdxV/w8kwX0CPR0oN+vJPib0fXPMR7nvmaUcyvvU3wM8FVwGpHBCYFTs5yfzvVcR2vLCpciiKefo+7aOorYd7zg5+iCs4rgEiPlGXd0qvFtM2vs4M/OHoc7sTl1XdBtCjhwKBLEwe+lfjhRJWkP/uu7dfxJDgyCjEe+Ospc6+fJ2u4owkXdV7UyNOjgWdQ9HDEd9XLRwNRFKIbSXQzqdRSqa/bPYX4Tw9zQeFEUbdwHIIalQMuPOgyXx0bJugUc8rtCLJP1dIQm2o10ArStxQ9qDWEspGqSkLNTYhjjJnYgZVBOywtFevfzoO/Phla5npKI2cvOJOIY6h9gKg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777976850; c=relaxed/relaxed;
	bh=tI4EhtrIIJ4yBILYloWUudhMj8Fsdk5INKde7w/EIdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcQ9pDg9ZKBI5XP0YwvdKll4qaaBBCOcINibosbYpnTWVgmBKsiGYP03BFtlRivORn+kQHlLwIJO9O156beCtS+gyDcAO2f4fHEDcCSFXJRC3K5kgoVkf0GN9zGgqD4Nha89F4pz+L1JuKb7ukYlmqebDVsJSDnvWxY6H0MDfHGwfCZAw7FGmaZPeAZlubrCV1e9Y3QWSemg1uRzjzq1fn1DGn/uhoYhrlMXDW88f+meky/E5RfFSsbK+cSMzJfG62GAuZhqFPSnSUWeeJgdu0rIP7bALOvBQwXkeuxtX1mgjITqU0kRASY/a/RApukPgjwl28JaT411vv5XF/WDyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G8KcKBgq; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eBB0yaeK; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G8KcKBgq;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eBB0yaeK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8vpT2nVfz2xSF
	for <linux-aspeed@lists.ozlabs.org>; Tue, 05 May 2026 20:27:27 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6459VTvp2859227
	for <linux-aspeed@lists.ozlabs.org>; Tue, 5 May 2026 10:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tI4EhtrIIJ4yBILYloWUudhMj8Fsdk5INKd
	e7w/EIdI=; b=G8KcKBgqaAvseHKyMejCBS2uyEALGXTriGT5iocMVfveVm3GlRF
	O5a/JbyUQG0suw34H3mj9iO6cwOz0WYw0jFdTnwpJDC+zONCvj5QEKyryRgAAiTi
	r5BGzwMu/XY4DdLnMeKkOOx3cSqmcalVBKRfbwZGxDulCRAjfpxO+NOb8rjhujjK
	zlkGMYS9XVdSfSdFcP4yNMO9d8C2qi9OmLk2IqtKQat6WAEU3yOF+Cd/veEtZRZy
	k2vPO+lhfzAkqo/oPHPNSeOxGIClkaFyWS+P339CixefPBrHkz9PEtZ5pjxSasvj
	wUp8+ljbuh5gDUNeqpZxjFl+zMAJjOnnG/g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dye0ag7vf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 05 May 2026 10:27:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d84b5f73bso173781211cf.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 05 May 2026 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777976844; x=1778581644; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tI4EhtrIIJ4yBILYloWUudhMj8Fsdk5INKde7w/EIdI=;
        b=eBB0yaeKY3Nqhs162CrLW6whCBJCdjUN6AIQYSy45PaYDUAKwgzcaMjJ0CrzeK757+
         mMRnNP64u2JXnTlrntzWjKhoFt89B/aOFyGkFNdMJWRKw9RK8PebN+darLXQXtCP4Sgj
         qv33v6gAt+JJVEotlhvnngNYRQd6++dwe4TJJuANwWHtR/KBRZ2tgH20/i/qjmORj/sz
         U8iJaogV54+b2Rr5pBZOE/26HP7QFgfO4WTTL+Ox/CMWr5cfJVly83HElnC3pBpSUQrS
         iZaWa+ZGrjhHW31sQ7Cp8Dhzlw3rwX9qCMUg2F0jbKBf3536NuknxGlv3ygeki7If5AJ
         cDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976844; x=1778581644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI4EhtrIIJ4yBILYloWUudhMj8Fsdk5INKde7w/EIdI=;
        b=q+RAKge+bQ+qd65djc1kdcVyGR64NIUomgWMBmMNtTl8m9ngQB2cJAA4drcoWzGGCk
         9T2hP9y+U3OGRwVVsDzYcAiAvTqHsCeI5GiEfwkCQqgKzjjaV2zp7ZeeyfDUsfj6KwpG
         y9TKA8+U3T/8/lA5t19+9KMPXta9bSFGjHZNIILw/z3nkEegcOwAu78FxzyY1QHy+1G7
         YUUOkm7xvC1MlQycSlqNbisY4mCcVjU7wUGcZY3MSfZHtO0aPMpKy+SweFX1C4TnzMZc
         L74VoJ0Sxo8S71dgsvU2K4b/Jr3fIHTZD26vyWqLLYU7ZrdncFxDYxNgGlkx3jXntKR+
         MASA==
X-Forwarded-Encrypted: i=1; AFNElJ8lT5ffDHYvTGhenXz2Fq6H7bH6jR8Rezh+yPc4lpcKmAMI487dli9vfTctQNHpjmUOMhH5JusURNZGzgk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQo6kIYXEdapZ2ykQYtOMZgszIXN0gxf0pkeWyHDmaTPoXhhoF
	5oWnCwAafIWvUzf4RNcvR1x25rQby2mwg6wcL/PP2UpamT6GGvlHrgt7nNpduI0pc2FADkkuU+U
	L9ROtVFKid1JcNoErFg0dA4v6DQQzFWkSYuhc7u/URPF8PXbkNbmdfpLR5uhxTz+r7jlQ
X-Gm-Gg: AeBDieuNGzQj3XaifzCGn5KybrJcRFNVhKP6+7zXnPjsFW1if+kuTqZFvcUFYBaDQhd
	F3M4U1jOf2bUqEL/mzbsQfdYX4SWjuuLjVVbAm06/8PUGI9dwazJjBwywIZGN9amDIEK5ZgID9s
	YB4MJkrLcmYH58Nj8HKcgCcb2+Yl59ZBomx3Hh4Pzh8CZEcrlxQs+/5AK8//X+gNChoy+3RoYFj
	eyDZm5dylxXKadp4A+6VcAclcNetnI5poykiS4Ad7IbcJr94O6O6aU0AmdaDUxnbU9eW/DiVAOD
	88WiH9pw2c9kbBP5Tb9lYfOvo1VhbeUcOUSoTxXPq0x4dgMrhKHFaIkPRiI7HUGASi5vT269Xo6
	VwM4ldrNcoq6kF48mKn235IWP2zl5hjMc9c0lU0lVPkTm1jK64iIZZPQ2Ww==
X-Received: by 2002:ac8:7f10:0:b0:509:26f4:64f5 with SMTP id d75a77b69052e-51306af4f95mr34935531cf.48.1777976843600;
        Tue, 05 May 2026 03:27:23 -0700 (PDT)
X-Received: by 2002:ac8:7f10:0:b0:509:26f4:64f5 with SMTP id d75a77b69052e-51306af4f95mr34935221cf.48.1777976843092;
        Tue, 05 May 2026 03:27:23 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d149eafafsm25183865e9.2.2026.05.05.03.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:27:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] soc: aspeed: Move MODULE_DEVICE_TABLE next to the table itself
Date: Tue,  5 May 2026 12:26:36 +0200
Message-ID: <20260505102635.160772-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3083; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=she5NLA4wtMK/gnAkAPi/il4IWhAxmj63xr3hxAWtc8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp+cXb/8VJI/Au5pK578tTNs6qT4zWQfmKp2fZQ
 ZdLifnJ6BOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafnF2wAKCRDBN2bmhouD
 16zID/4okvRPbaU4lDgl45+1AVBLI/o8TEe60g2SUHubWWdFQMIeas1fcmh5BSXaLWmWLsW2mqx
 9vtrSXh7VCj/wFZ3l0MGw1io36hubwtdrvPlH0MnlHbc8f/enOPWQ6EYo+jD2ZVWGhkaiauojfh
 nwDT5oV0bkfelVUa/FCvBgdgqLujwfQgPBbPgMY4qhvD/YSzEw8gYKvJ4vSGXDzTuzwldRECMS8
 UUgQm9GqRi2lDluWMlQs2H+604K+xQ9Cd69jSfNMr7WI6T8Deotvu2+lUeZeuqD3rYJDMJev+Qc
 GwxMKucH+DQQg26W57bhTzCJMtwwNBdK3iLaNEwXuIqGV6vsjZwofFkXsKqk5pabOkNZOUrGD/F
 S5dqXimFiCHrCO1ksst2bdrisMaY+dmhHE2Sq9zC1u9X66womTHySNe4j439T1KMgJYZtntePxW
 AdLjDgDbobTpa6BDDOxsytoWquwtUrOYE70EHA7C6NUK4UH1FR4tg5JA1X/lBvFAdCfCkc1KLqK
 ROR47SJyAbdTkIDcDXjT/BkDVij90tZTAGjwCV6zMLDnpcU9rmXIQwlLb50maclkIYCOsAQpEgX
 wpE0cCHFsknNW35VJQ42btEtsMbtTlvK1ADwKvonbYToL++jzXKT/fPz+pCFnXpawx94oVqcc0v d9Z7A+k+l+SeTYA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5NyBTYWx0ZWRfX/8b0tjRV6Xf0
 U7zez2rxbRpOxZGTYYcNR81X2rJiIywumek+BA3pqmbpZwAjyoZc6BMVjNRlsblNjnK0PDi5Bjt
 VTS1Cxrkt5KC+N01SzAqhLRM3DC0etP+Zgy60rB3jq9tkpmRNDEJ9Xq/rLRRgx3p0I0yzNBC5pg
 1Y/hHKaXx88+buJq43tAcl4n8n/ajQsPLwY0C004woK7JavJ+t2w02rksIotCWbWYArJg2jV7S5
 ytw5O9e03BknLhXo9OsylHNVird8udz6R95qnZftrM5N6wLVBpu6y1EBrIWWSXAwd9wLUpxHCbL
 5z2piLENFEIqb3wrwppu4ircv8w84OkW+9HoNBpDSJpAu9+PYely/+JZS4PGh8PnREFEV0ZUwN1
 6fUE9cCxxYga45Sg78ZV/4+Ft61q6tDAMZ9oj+TA8s4r4ptRAi9ASqHeW9EWaqpew0mwz6TCMDT
 UJIWrkVLrgpdAhUrlhA==
X-Authority-Analysis: v=2.4 cv=Wtkb99fv c=1 sm=1 tr=0 ts=69f9c60c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=awhO3CD32pMT8nx_-7YA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: MtAyVKZCvDBWzfAFWlFrMhemLUgfIRaJ
X-Proofpoint-ORIG-GUID: MtAyVKZCvDBWzfAFWlFrMhemLUgfIRaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050097

By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
exports, because this is easier to read and verify.  It also makes more
sense since #ifdef for ACPI or OF could hide both of them.

Most of the privers already have this correctly placed, so adjust
the missing ones.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c  | 2 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 +-
 drivers/soc/aspeed/aspeed-p2a-ctrl.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index b7dbb12bd095..4d8574cac703 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -338,6 +338,7 @@ static const struct of_device_id aspeed_lpc_ctrl_match[] = {
 	{ .compatible = "aspeed,ast2600-lpc-ctrl" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, aspeed_lpc_ctrl_match);
 
 static struct platform_driver aspeed_lpc_ctrl_driver = {
 	.driver = {
@@ -350,7 +351,6 @@ static struct platform_driver aspeed_lpc_ctrl_driver = {
 
 module_platform_driver(aspeed_lpc_ctrl_driver);
 
-MODULE_DEVICE_TABLE(of, aspeed_lpc_ctrl_match);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Cyril Bur <cyrilbur@gmail.com>");
 MODULE_DESCRIPTION("Control for ASPEED LPC HOST to BMC mappings");
diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index b03310c0830d..28e491fffc7d 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -366,6 +366,7 @@ static const struct of_device_id aspeed_lpc_snoop_match[] = {
 	  .data = &ast2500_model_data },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, aspeed_lpc_snoop_match);
 
 static struct platform_driver aspeed_lpc_snoop_driver = {
 	.driver = {
@@ -378,7 +379,6 @@ static struct platform_driver aspeed_lpc_snoop_driver = {
 
 module_platform_driver(aspeed_lpc_snoop_driver);
 
-MODULE_DEVICE_TABLE(of, aspeed_lpc_snoop_match);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Robert Lippert <rlippert@google.com>");
 MODULE_DESCRIPTION("Linux driver to control Aspeed LPC snoop functionality");
diff --git a/drivers/soc/aspeed/aspeed-p2a-ctrl.c b/drivers/soc/aspeed/aspeed-p2a-ctrl.c
index d88abc5f195b..b6b7b80f842a 100644
--- a/drivers/soc/aspeed/aspeed-p2a-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-p2a-ctrl.c
@@ -416,6 +416,7 @@ static const struct of_device_id aspeed_p2a_ctrl_match[] = {
 	  .data = &ast2500_model_data },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, aspeed_p2a_ctrl_match);
 
 static struct platform_driver aspeed_p2a_ctrl_driver = {
 	.driver = {
@@ -428,7 +429,6 @@ static struct platform_driver aspeed_p2a_ctrl_driver = {
 
 module_platform_driver(aspeed_p2a_ctrl_driver);
 
-MODULE_DEVICE_TABLE(of, aspeed_p2a_ctrl_match);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Patrick Venture <venture@google.com>");
 MODULE_DESCRIPTION("Control for aspeed 2400/2500 P2A VGA HOST to BMC mappings");
-- 
2.51.0


