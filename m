Return-Path: <linux-aspeed+bounces-2371-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C380DCAC5BB
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 14:45:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccHlV5rZ5z3cfT;
	Thu,  2 Oct 2025 00:45:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759329910;
	cv=none; b=CTG1ESQn82FgGvNK1GtXphJ9On+OV+7Y5gLg7Lb78b7WMnCnOK3TBilTgOh47xb00mittg1PJFSEjfRsuKE06gOmYaaMqaRMTGK7dilqcc0OTlzDq7upMl5ieQb3CMTIB52AEXpjcgWgpvypdjDn5gQmlck6WtKcVht7YxiSQQGsDs9oTT3OuTZMeh76T+iqsBsS+S+jlxkExb5ge5a7vf61jWaWURGTfVNQWnXXW8+JP6n2bFnPxDBFFOoofSW84m/gObUFqYR5p8nKoX8fVqDAz7IP6Z/5DI9IXL9WLuMtsdQwbYTZz/6qvl2eP7m/C3pe5hk/Y2MNtFC/ijGBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759329910; c=relaxed/relaxed;
	bh=fF9atfBGhzqb4KhbUvP6g/mO8dQyz+omul09LHYAz+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ggjk9ZLuJyd8qYMsp/x72OzSkJyymcV6CrVLDzllOtLZKEKAj2P3cLD8bOVJ6TQnA7z4YZxyV50uWbi6DKKclJsfsZOfYBFgCADaruNYgvrmel/68NxfUMwznRIoKyqNdvVpFBTFaCFlNfMDG+pvtuBDnm39uqhCY1AHYXPea4qAWQ6fbrVd10udBYYGXv7/wYPP5JfGxSh8WkwQh1g9mrKIBXNk4kdq36c9M9G/wpd3ARObvjR0998CLtEmQ+34YYYpME4nyV4wpJKRIkPXVVG1v3MtZ7FsUWo5DQoT9hMSJ+WHrg/Mm2TUlfm9iJIhMD9JH3B50Pi4Is2L7fjLSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Uul9dGu8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Uul9dGu8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccHlV0pRVz3cfW
	for <linux-aspeed@lists.ozlabs.org>; Thu,  2 Oct 2025 00:45:09 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5916Y4qU008978;
	Wed, 1 Oct 2025 14:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fF9atfBGhzqb4KhbU
	vP6g/mO8dQyz+omul09LHYAz+E=; b=Uul9dGu8aL9eEhl0rFqVjPiXpjimItO2W
	kH9xchLqUtsZitG04cUdT+kS+C9P3D2XNNRNqEOcjzSMju6HzKRqPLlQiR1oR9xF
	ekn6UORDkZSs28OCaJczPVFELrSjjfmsJXWawsJa2TLkYgYZbO86Z05FiYnqMHsl
	7R2uKI0xqmBoSuGhilqcWaMQrkIbTHA//utu6zl5Obl0sG0wfsHot7J3T00AjDV8
	ohiD+43E6oPOqayRkiFEEIGpDPUbkJaVSeHRbGoFQzqKpaBWpgareKbFAc9t9eA0
	b8RkOvBgh7yHdVnaeUhNk6yx1BhrX9i9x1X7LGk04DzjjaY+FcIDw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqyjfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591DE2gw026746;
	Wed, 1 Oct 2025 14:44:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8n197c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591Ein6O27919002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE91258043;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D55058059;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
Received: from slate16 (unknown [9.61.71.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 RESEND 5/7] dt-bindings: hwmon: max31790: Use addressed fan nodes
Date: Wed,  1 Oct 2025 09:44:39 -0500
Message-ID: <20251001144441.310950-6-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001144441.310950-1-eajames@linux.ibm.com>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfX/VcnatYu7APw
 fCYsoCTi02TpqW4mqGvbTC0Q6/rlD+DzBJyPzXDUnrOQE1Kk4jBQogL7oZ6XLrv+1VQQUU9O0pD
 W9rjogTJmyoMlDdE3JOLxsLax6W/eZ2YlMYF7RQTr21tWDg3HQe3LTCoBEUMtI0ChWl4CRz10i6
 quXKYNPQNUYfEQPlYmaeX3WdcEFwfXUEZTQNHbF20fu6ffGc1mXIYeCLvHaC061RbkFbIFxK991
 ebt7YBpxUWjdWEGBsXnh/ovXJDhlGBCGtheDr52/u+U9iowNFwUSR4cxM9UIfnb6cwRPIGDrYv+
 /UN7wYt7z57BHz5KW9GnXw5nKfv8D+GciRhca2itB4xgftOsvN+pcS6flt4G+sQueCo9D8JO9aO
 gyc8xSMHSu/3lynFABsi53dc2J/HXg==
X-Proofpoint-GUID: TTNAdzhCCVT-C3MFVnJgGMPOmKCgX0Fq
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68dd3e63 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=n6X2Zvpy7yjbfLGLM-4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: TTNAdzhCCVT-C3MFVnJgGMPOmKCgX0Fq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214

Since fan properties can include reg, the fan controller should be
able to specify address-cells and size-cells properties and use
an addressed fan child node.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/hwmon/maxim,max31790.yaml           | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
index b2dc813b1ab44..558cbd251b0fd 100644
--- a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
@@ -35,11 +35,17 @@ properties:
   resets:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   "#pwm-cells":
     const: 1
 
 patternProperties:
-  "^fan-[0-9]+$":
+  "^fan@[0-9]+$":
     $ref: fan-common.yaml#
     unevaluatedProperties: false
 
@@ -60,13 +66,17 @@ examples:
         reg = <0x20>;
         clocks = <&sys_clk>;
         resets = <&reset 0>;
+        #address-cells = <1>;
         #pwm-cells = <1>;
+        #size-cells = <0>;
 
-        fan-0 {
+        fan@0 {
+          reg = <0x0>;
           pwms = <&pwm_provider 1>;
         };
 
-        fan-1 {
+        fan@1 {
+          reg = <0x1>;
           pwms = <&pwm_provider 2>;
         };
       };
-- 
2.51.0


