Return-Path: <linux-aspeed+bounces-3315-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157A0D3CC82
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Jan 2026 22:23:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds0xB1PQHz3bf4;
	Thu, 15 Jan 2026 09:22:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404641;
	cv=none; b=QoZCmAAt1Un/iOXsIwETI+NcWnUZSGZo8Nb0fCCBOYRHwlRfXjUIBNx06zoqFMxgOAbUc+ErqCkP596ppkc8dFneCzMT0JpF8D9piS3GrZoUABmtQC6RyaFiwd7OXiMTuG4cDmz7bt5RSXiEmwx2czJKJxS03EJfalbtdWwLFkdOLJEPkroz8mP3rDR/Ld+SgJRt4AP47rx9aiAX6B9Ka/J6M/CvAi+U6ybZYn6kpXZhRwEwbihEec7CyZT6NWmB+qSaVojlyzDFuRa+6/dtLPz8YgXkZQzJuXzz+9IP7iZxKShLiXxO+yP1ZSq+jlnX4mECiXg6n1cknWWts39C6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404641; c=relaxed/relaxed;
	bh=taXBNyuQJxmj4iOFqIUfDmb0YEDOzZ29KLE4Dq+0LV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5aaEiLSrBFx1zWI4MntRIxMdVehD5hgiYLCeQJwFH59ABq/a8EHXa/xsBQPg4mIcY3QgrYbbyuR8yyAuUqUHagOynFVfwHZHzinY7UF/4TmJGKHZr4suVNh0jEsJpBmHNwi4mNNcCvSWQwT+0S9D1a1AodDCyfo3uPFzHfmDkUkYg9NpM/ZzbV8OqaOR7kARV2w06TCiq87rEYox5ZGFN6j6ZfMmWZG9nno/7UeUZgavsjb3PPatVIbBe7uWvqKInU41thYTN+BXZ/K3KH8QYfw89KB43jNgaUysfuNGlZSOalheob7/JD0+rEd1PzJqrRZ8PFixFC/jQZF+QUjng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oI7iubuJ; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HoanZl5j; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oI7iubuJ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HoanZl5j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqnY0mcZz2xYk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 02:30:40 +1100 (AEDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EEHD5X147897
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	taXBNyuQJxmj4iOFqIUfDmb0YEDOzZ29KLE4Dq+0LV4=; b=oI7iubuJrJC0fgMI
	lUkAMQMVAzmfEMIfufrp9rsjWsXcH2o+6+++OU+t1AgtWvYToBTqLzfCTJ5hbWWc
	zsOmvaBPgp/FPEP8JHQwucbS/WuYShGxyW+lgPoVyVgGAfV3FaYqJ4LDeQjsxxWb
	Hp+0cgOkI35fRxgRp+kIaZ0O0Kq0Jd8CNCAK9GvKzPufghCvcwz0vq6alk+/IZLN
	+Yvdv6h3DUvdafI+5Fb+qaCxdCVOlggJXoBSasoUUjTrHxP+nU8ZL9/9fuBl7ZXb
	GOHzOvBGPL3LIchFN7uT6MG6DvhW9TaYkkitzZ1yRJ71Tmhn3kONflVTlxvRYGfg
	EW4g6A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp6rahphh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8bb9f029f31so2434737385a.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 07:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768404638; x=1769009438; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taXBNyuQJxmj4iOFqIUfDmb0YEDOzZ29KLE4Dq+0LV4=;
        b=HoanZl5j6xfjklgDd7r7lk/HcCnAxswh9k4E+qSdDgF3uYUOVAlgXWTcUHMU0D8vC3
         ToG0WEPpLDl8PHWLDe+b41aQaDXv5rR8ffjzCwAHpamtpyDvFMHWYTY66wWyzNb3qFEI
         pDrjx80QBGQ0SffGAI/vFR1MF+uKYldpgLqsybJF0kix59nMMq144l7sPX5US4CV1SNC
         PDdr9gV9Xcgq14/zGGxh4cCITnlU0fWf/CTYzBYoQQgppPNGcI1EOQayQaa8KbkcsnnX
         a8EUWT5ZbqD6JtdfUr2o4AiSY/dY7fkXE3TuZELmFFzCewuCytY4I6i3jVuunSTvoas7
         Nhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404638; x=1769009438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=taXBNyuQJxmj4iOFqIUfDmb0YEDOzZ29KLE4Dq+0LV4=;
        b=iygCe0ari1BsjLJwtslqBp4+Djbzr2a3uSLFAodpqCerSfK+1DhazUThRE25FmA84e
         xEQewNfoU6P7tTt02lW9qZXWq7j4wjSNQhFaUSNAUuS17DH9LWBoY5Ok0ZG7Cz6yuziA
         18YxalReJYtWGtmvLb7ZdQ0+EwlecjT1m7n4tB6fjw7x1GQolsSuQ2cJCXd2DPWZV8dG
         iugA1NkSaFML3ZVZFOSqLJ6lZPng2dc8MmROClD7VHKPAtP9SNp8w/Z748fqNTqEpGQC
         1LMjp3k687KH5ImKZiingJXPZVvlp2umf3Cn4nKdpwaXsfMhO6W84eoGcxTz5kTe6cUS
         mcTw==
X-Gm-Message-State: AOJu0Ywb856UoffDDDwsvdmbvzceDk3YltHz/8PEoxtuPTGQemHfp7e2
	Z5EEm1NTuiou2fTki6Q84+blbP2ROI5SFJC/IHXwffUpvArbvx9DAznnzhUjodXT/Ew6XNMe7PM
	WPaVelu8vofdOEGKwLfLaRKu+PH6GUnBHltZdR0FXU92+lwsNqgRT9RyjDrcnH9YhDjRj
X-Gm-Gg: AY/fxX6oSf76umdRRJopDynGxC+0zWu067TZG0Lkd3ns+R5B+0TIYhOWvr+2fKSgEd8
	tHX/3sFJezwZs+zy2VLUqz83QKsrlgOpRC/+EZBm7AEGelxp0NdDbZiQUFzm5bVTfgqTRsCjFcM
	tBrxDcpSXHspeqm79XE/8piiXzpYEojDXAxwvULISracGZuf2Uxc5ycREzC8cVw7t2XUs0xE46k
	R1o3osCNUdUpeOiRBUrhJz53//eS9NId2J6N/jA3YzA7VjmOjEx9/uKBRWThwwGIhrOZ14791RB
	oHqagN1t4StXBTXFrS7Sf23VmAJmURugXrWmlS2qu4zxXwycgQdNHYID9hQAeyx15/33N1T8Nf7
	YHY5wo3TZlwkNq5IFgP4UWw/PgNbepoIjmA==
X-Received: by 2002:a05:620a:6ccd:b0:89f:5a59:bf30 with SMTP id af79cd13be357-8c52fbffa64mr413614285a.78.1768404638304;
        Wed, 14 Jan 2026 07:30:38 -0800 (PST)
X-Received: by 2002:a05:620a:6ccd:b0:89f:5a59:bf30 with SMTP id af79cd13be357-8c52fbffa64mr413605785a.78.1768404637689;
        Wed, 14 Jan 2026 07:30:37 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm22812989a12.29.2026.01.14.07.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:30:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 16:30:10 +0100
Subject: [PATCH 09/11] pinctrl: tegra-xusb: Simplify locking with guard()
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
Message-Id: <20260114-pinctrl-cleanup-guard-v1-9-a14572685cd3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Hz6iLmKEfxDKfrrjH8upUbRNGTU/avM3tmt35o0Wjvc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpZ7aHavwX9VGYJNPXqlYS557XrI51pw+HBiAgS
 ksF1auZQ8aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWe2hwAKCRDBN2bmhouD
 14N6D/4u0Ishpad2NsggJaHhekQq6iqnAlDq+P4aUzZ2je0asU428AUXHgBNvCHiiaRNuJ7peKn
 kZaXFhOLRJL4lxXomi8DHl1w9D1wmI2dmJY6uuG7+xE0WxinMpd5kVfeW2Xtb54zER0cJh1D5bI
 sVk4n6tZOECbNOeSCkDuz9iEmckynK/jzlrOtYLy0nBFnaMx4id35WfzzlMbiT2y/C/eloosWov
 Hmaa4SZ3MfGPYTu36FG2d+rvHNNb9+WSIuzkjv+VTj3cK17PThBorYGBp/w0aJ8TZSzhi06ZV9p
 muZ8lj8SdZ97AguyfiMxk+Bn7pnrY1uffQ50Y+89Q0MUkED8IzjqPDYMxxlEPSUsTi4rcPT/Nwf
 YjxycS6wVR7jaqPzsW9sPjVnOGg4m4RSiiD1UI2kij+foiDbWUDEcdzMktasIlpA2SELsmvfpKe
 NkKfC/MRbCi7phtLl2BQz7sIegR3+lh5wHlWf5Bp+vdP/TwV+uSXTTrwiRsQhuSaTR+J7imqz7v
 rKwBAo7jL18AC5SjN42i/KN+kBPDr1ukX+5zCgQGI6rTDSkYOwuTeWTgHMyLQmymCwjNAz4SbuG
 wHlm83t3XUAC1jznj2naoOonPyr+Xpa9qqPg4IfTnnixh13WCTfgidggeW++iXeRSKLA/Q1o09+
 FxL7I1nczulzGhg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMCBTYWx0ZWRfX+J1sW6vfL8pR
 S8KHrLAr3FO27TeYEvaAhzmIikArmw3k/K4PoVAxtWdG7xEkFQvfj4SJjsEDeKNquDdhjuWoUdB
 SPdXuAuiz3RZ6F7Mkr9pmODanpbXKVu5hNjYkrBgtzrVjFuNjkILlXIXVu73fT1XhGf2v2g2ymG
 oVWlR9tKmA2w6wqkOLHI1ut/tBig0ABukpW5vKbmZCET5yKF9B0+9ujTNJJPuGog13Z9Udk/a5h
 hK7kA6T1IBRkj61JTV44HA1sQPpue8l6ST/DSspPTgWcNpZDdvOdHD2H83oiA9+vsa+uhjzMhp5
 rxvZ3WbgE1funVJeqXyIGZ+HJDavJX7gb0NIN4NjtKGOncuPLVHUdVn2nSiHCYxiSGL5r4i0Qkg
 IgBRbONqc8g9Cxy0TX/8cyyN1o9/o/TiDKlmq0+mnycmTKYCenMSsbP4bvyDoyeusRvuyF8ujzR
 HkT68+lHf3eAmV8LasA==
X-Proofpoint-GUID: 29lIHEViZzO2S2-7HAI9ZMte5aWV5ZlN
X-Proofpoint-ORIG-GUID: 29lIHEViZzO2S2-7HAI9ZMte5aWV5ZlN
X-Authority-Analysis: v=2.4 cv=L/EQguT8 c=1 sm=1 tr=0 ts=6967b69f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=aRO1tsgHJH1V1zxVpf4A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140130

Simplify error handling (less gotos) over locks with guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
index 34a373f7e04d..855f708ce510 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
@@ -478,10 +478,10 @@ static void tegra_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
 {
 	u32 value;
 
-	mutex_lock(&padctl->lock);
+	guard(mutex)(&padctl->lock);
 
 	if (padctl->enable++ > 0)
-		goto out;
+		return;
 
 	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
 	value &= ~XUSB_PADCTL_ELPG_PROGRAM_AUX_MUX_LP0_CLAMP_EN;
@@ -499,7 +499,6 @@ static void tegra_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
 	value &= ~XUSB_PADCTL_ELPG_PROGRAM_AUX_MUX_LP0_VCORE_DOWN;
 	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM);
 
-out:
 	mutex_unlock(&padctl->lock);
 }
 
@@ -507,13 +506,13 @@ static void tegra_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
 {
 	u32 value;
 
-	mutex_lock(&padctl->lock);
+	guard(mutex)(&padctl->lock);
 
 	if (WARN_ON(padctl->enable == 0))
-		goto out;
+		return;
 
 	if (--padctl->enable > 0)
-		goto out;
+		return;
 
 	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
 	value |= XUSB_PADCTL_ELPG_PROGRAM_AUX_MUX_LP0_VCORE_DOWN;
@@ -530,9 +529,6 @@ static void tegra_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
 	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
 	value |= XUSB_PADCTL_ELPG_PROGRAM_AUX_MUX_LP0_CLAMP_EN;
 	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM);
-
-out:
-	mutex_unlock(&padctl->lock);
 }
 
 static int tegra_xusb_phy_init(struct phy *phy)

-- 
2.51.0


