Return-Path: <linux-aspeed+bounces-3317-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F881D3CC82
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Jan 2026 22:23:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds0xb0xMbz3bhq;
	Thu, 15 Jan 2026 09:23:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404637;
	cv=none; b=Y0Qstac8UxGmKkQc5UgJACldK7V/Q6XVgkPTmDtegIaDEFcNG1o6u/Gq77MnPBBSK59h4J9JadRBYRkwcswCKoIAniH9Y8aPIqJvkL77gbXtl03Yz9DDgq4Y5gVRfdeqTA4TQ1HvbtUJnQ7lEjuLKsJ6x2dGjZF3oadRBQD0N5ubIABkzInBB6H1NOhsIv2vrxeLaBmZ0xukHEhx4qSJgTWkiHHK68fFrXPAE9XOUNAQqaoJBMhHGSJEOlbW7Y0UQo0qSp/g3WP55mvg3UwaSSedlAl9yN7AwKVPpui7Toe36csgExYVuGvPgaaENk9bUt8X63Vyk+5dC0G6JhAGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404637; c=relaxed/relaxed;
	bh=VMrQrzLzDincZEvSf3IY0LWe8Yq0vnY3RbOd9IgAleU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DT9u1iYb//xDP2FlEgkTq80bfk+Hr5eUnRI9Qm5nCm3+BdOyxTJtgg5LjvYWGeUGRTb2jMEwPizQyFb17gxVGcnGSCKcgG0jEsMp8btAzP5EroBqgsCeh6XmKrUkn2V7KBEYpHiE0so60U8Gq7G5VO7fTIvP3H2BtyfxY0K6jRtmLNzR1P6SnPOsBZsfsy3BAna0VGRB58b3FExOAlbmUM//VF3zTZSk4bbG7UqgGolQFgJEAek1IRxn/NmhbDEG/aROhV+7T8inJtJ6e4t9Ssz+SbGkeEjcGv7A4zd90DXh+A2zrfn96Jw8Gcivoktxd1K/L9CRI6FnxNe9sgC7ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I6kkEHcw; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UNk7nMOd; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I6kkEHcw;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UNk7nMOd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqnT0m11z2xNg
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 02:30:36 +1100 (AEDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EA4uSN2902726
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VMrQrzLzDincZEvSf3IY0LWe8Yq0vnY3RbOd9IgAleU=; b=I6kkEHcwYHnmLqcC
	bCog3zsSNQt83q1g15rqSXMAHoCS6ayKBCuK/od57mJZRARRmEKWePBZ++KRDRFf
	nA/wQ3gmm9OmhEdA75fhn5wCblufkPBQS4FPjA1MLG8XjHUW5rpj3ThuLbR54inW
	ZC5Wo+bUgahzHKYqqo6mScjg1mnK/iL0PhMHXVhGcvGY9zbAELUEeRa23OKCvh3x
	urMzRY5AmgIdBLrvSeX0LZzwdcJr7L2+2n1AHSumMEuqSkZsHx4g6FgrUQB+0/FM
	xIJf0EElVUNgq68df0rWEdMcPXSuVq5wvOXdMLZwdMvExgqGYam5JXWk6HI6mWVO
	XotTrg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp931h2bc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8bb0ae16a63so1031597885a.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 07:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768404634; x=1769009434; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMrQrzLzDincZEvSf3IY0LWe8Yq0vnY3RbOd9IgAleU=;
        b=UNk7nMOd0iNoBtQj2IlD9wKZXVrlEHgR1NtkTf30PNJylPGrdu4y2pWTbPCAXkWyaO
         9c8x6FESlGaSiMVIg5T+sjVVlsqIBlH/bdackngzglEvNTKTFspWVrvg/6v+1j8pdaxD
         n5drQMdxxZwT76dZwTnikDREGhg0aMsa+iinfFpUKAoCFhFzK01y42oEfER9qEZDwIf6
         4I72aAVBbQ+ve7ieQ1j+5nv6zwXsbvWF2pF13DHe+Ct1ISDA+YDN0gcb4+HAEGHAFLvN
         VNnfDlVvbJBHrWoD5jBmUItOjIuEMGkruePhmO+mWIRFRmpBe5xdWku/DLt43Z6OL/Yc
         4gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404634; x=1769009434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VMrQrzLzDincZEvSf3IY0LWe8Yq0vnY3RbOd9IgAleU=;
        b=XbuJjmuyYeL++2MzNK/8hc1gN6yGdcVBgU9icplwp7OH6lxrpe85f3WoHJd58PrJ/D
         lnLpaO6zjbENFPOm0fpz5Ah/sxn80frH6rUVng9FDbfb2PQsLUxOE9V/6bvPhqX3HFJ4
         eq21L6fm2nTXP/CE0SJ0P0UitqB8ZrHhRWvZslIwcljc9cYdw+6EBee3dzZ1M9J8sOIo
         AqvFZHLra3a3BkO7CYogJYQEX00dI4h3NGNJPXFoumb9P0bWOsDrV29rShfNsnz8q0u1
         wDATgA0k4AXj40ckaf4UyknZWuKDQ6t4d56tTsZWshNdwnT2J3PVIPOuJwUItA8PTpII
         6PoQ==
X-Gm-Message-State: AOJu0Yz1ngk3lQyDk07sRS/DOprS2EiotN7PfwiShm/4hPEazGcZViGL
	c8Bmph7SyQTOGTFCsCplwosd4b+0pnpmAcjz0XklBbRl9DwEqVRcFSOzedXWlUb7zVx1vx/yy0J
	zD6yRC9gXVvfgMtL8daJOoFDug1b2Kvra6byauyTEZTuQ1HX/Old+AAFryDmwg5/Mk8xQ
X-Gm-Gg: AY/fxX53k3GrcypYvyaUmjX9UcTIAJScgWm/476MnAkUPpmg/kXMq/OFDpfjjKM52zg
	JUuOcxXPe3HW912+zx4CXbeSET3XzzmgT19ogM1SNSxRnnFPcayBNHdJgEtXqBHJQn/Sw9K3K8o
	qDbCTnFvBFrElzEWN63cHQ5R+jiMB/zum9hEYjr5I51szceK6611Ix/T0R4B3RTPAgA4ODxrYUO
	xjmVN4/lR5kDwylcs3YroGZ3y/V/atPuqNaEMRG+0sjfLZA1aOrRE2J0RMZhy+NCTYrNj3u2Jeb
	fmM93ppUi0Zl++kkjiEEefKWuWa6csonK5eQJNOxRLDuCk9ymZ94z9ehODB7/gMcvOQ9XmOOgiu
	6jArXmpLJL+a9v130MsTeKfGqwoWRWEKzxQ==
X-Received: by 2002:a05:620a:4101:b0:8b2:d56a:f301 with SMTP id af79cd13be357-8c52fb32b67mr343231685a.14.1768404634198;
        Wed, 14 Jan 2026 07:30:34 -0800 (PST)
X-Received: by 2002:a05:620a:4101:b0:8b2:d56a:f301 with SMTP id af79cd13be357-8c52fb32b67mr343223385a.14.1768404633459;
        Wed, 14 Jan 2026 07:30:33 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm22812989a12.29.2026.01.14.07.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:30:32 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 16:30:08 +0100
Subject: [PATCH 07/11] pinctrl: tb10x: Simplify locking with guard()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-pinctrl-cleanup-guard-v1-7-a14572685cd3@oss.qualcomm.com>
References: <20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com>
In-Reply-To: <20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=adtV57CgOwnY60Si6YEP4k65ve4WmCO5x4rzf1ZqeaM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpZ7aFRdTPwiFL/h2YLFk/n9wL4n9QTdVBj0L6r
 8aUJ0hOsNiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWe2hQAKCRDBN2bmhouD
 15BvD/4sSskWeqqie+QnWNfV5njoEI/Dxm+OQU6hvQfAn6W+mFLEoVNCYY1DYciSU2Abpt2R3nR
 +qvBID4STILG6i8SyHTuaGcand6oW9yUTQpRJAmZLQwTU6t5Txha1TR6xku+5Oy8NyzMaHRuJTv
 +q5GGceQij71KHq+iN7y+f2Kh47ZLjY4bh5UEgUQ2UIoWQOKsKGVqFMR4D+URpgUMijJNLMK1eY
 OiA7jL0EBA0jRXolicdtAQTBVHk5WKJIlq2dKAIVzHYv12gvTtggiJd6gKyNR8t5tX+yOxZqM0D
 Jd4RwOyuhKazwxCfXv+bUlaqLfNnifpec2mksBSbNjseAfzxvkqxCt+VMZHZVoZ9mzpRmAppP30
 i9SP4gbwW16v6PBBhPIiLG0HrWfQ9XJ2JH7MYWKjn2JypFxHEA9Db766OZxcFqNRKVlsMAtIK06
 ZKalbIjY3hmQO2RLFsbhmE9qgNQm5n6vPYCORIFGTSFmcIKyeFghhXkkuZqhqTORTVXwOoPyhnb
 rrCyYVw4Twlq3ASI88CvQgLBkMD2dmqaPlhTZ37MJzVXVgufCKwBDhrq6xhuAlBI1vufryly9SE
 iw2aWK83dO7QfgeR/uYrjPKYMLwUfoTt6nq5Ph8Apc8jGok5zHX7/Xej2gYuXZnBbrTOGD48Hiy
 LRCCfd8e1rw2F9w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=BOW+bVQG c=1 sm=1 tr=0 ts=6967b69b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fB2tTgKqvhDdEbG57mcA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 8ZaipkzWFNB1f3ik7DI0et3U2Tcovzpw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyOSBTYWx0ZWRfX+xCILWQ77xWw
 YcIzxMqgxfkfdt2l7Qi0pLVtz3mReOnWT5nLg+h8Bg2hcTE7SlX1IISrJxbrvLnItTJ8B9eMEUq
 Oxha/F/Zl3c2zSffEf4nqewwoRVTUS+ub8VJxpOkQ3ihaqFhMc86s36wcuiowIgeqZHqeuRwWzW
 GQtK3LgEG60zEO4mGv8DFiDOK7cN2DC+xsIKcvJdk/oy7kq51DhjVYK8W4/DgouxY32/cM7JRhN
 wLzK5DzfB8v5HOgmZixnByC2TVcbgB49mhqwilG+XqLF58vzjAMwsTin067jcq+jmNUGO72uime
 SEJjKxT9BGDExv2SwELTqV3hrQYZnvpBFy1QsdMzQG1fZgCDyZzCeyoVzg5HCamJw80lgJ48qAV
 xVmo10qDjEGG6SUZ9FGz04cKlkcaELY8AG2TE8A5vr9fGPlBvWrKuF/SZL4SBekgHyp1CerrYIe
 sKWDQZVMVDlwJVSAhIg==
X-Proofpoint-GUID: 8ZaipkzWFNB1f3ik7DI0et3U2Tcovzpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140129

Simplify error handling (less code in error case) over locks with
guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/pinctrl-tb10x.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tb10x.c b/drivers/pinctrl/pinctrl-tb10x.c
index 129fa51d13b1..3f581404a9b9 100644
--- a/drivers/pinctrl/pinctrl-tb10x.c
+++ b/drivers/pinctrl/pinctrl-tb10x.c
@@ -607,7 +607,7 @@ static int tb10x_gpio_request_enable(struct pinctrl_dev *pctl,
 	int muxmode = -1;
 	int i;
 
-	mutex_lock(&state->mutex);
+	guard(mutex)(&state->mutex);
 
 	/*
 	 * Figure out to which port the requested GPIO belongs and how to
@@ -642,7 +642,6 @@ static int tb10x_gpio_request_enable(struct pinctrl_dev *pctl,
 					 * Error: The requested pin is already
 					 * used for something else.
 					 */
-					mutex_unlock(&state->mutex);
 					return -EBUSY;
 				}
 				break;
@@ -667,8 +666,6 @@ static int tb10x_gpio_request_enable(struct pinctrl_dev *pctl,
 	if (muxport >= 0)
 		tb10x_pinctrl_set_config(state, muxport, muxmode);
 
-	mutex_unlock(&state->mutex);
-
 	return 0;
 }
 
@@ -695,34 +692,28 @@ static int tb10x_pctl_set_mux(struct pinctrl_dev *pctl,
 	if (grp->port < 0)
 		return 0;
 
-	mutex_lock(&state->mutex);
+	guard(mutex)(&state->mutex);
 
 	/*
 	 * Check if the requested function is compatible with previously
 	 * requested functions.
 	 */
 	if (state->ports[grp->port].count
-			&& (state->ports[grp->port].mode != grp->mode)) {
-		mutex_unlock(&state->mutex);
+			&& (state->ports[grp->port].mode != grp->mode))
 		return -EBUSY;
-	}
 
 	/*
 	 * Check if the requested function is compatible with previously
 	 * requested GPIOs.
 	 */
 	for (i = 0; i < grp->pincnt; i++)
-		if (test_bit(grp->pins[i], state->gpios)) {
-			mutex_unlock(&state->mutex);
+		if (test_bit(grp->pins[i], state->gpios))
 			return -EBUSY;
-		}
 
 	tb10x_pinctrl_set_config(state, grp->port, grp->mode);
 
 	state->ports[grp->port].count++;
 
-	mutex_unlock(&state->mutex);
-
 	return 0;
 }
 

-- 
2.51.0


