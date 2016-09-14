function Result = ScaleTo2Pi(Phase)
  MinP = min(min(Phase));
  MaxP = max(max(Phase));
  Result = Phase/(MaxP-MinP)*2*pi;
end